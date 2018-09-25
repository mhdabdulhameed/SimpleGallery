//
//  PhotosViewController.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/21/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PhotosViewController: UIViewController, ViewControllerType {
    typealias ViewModelType = PhotosViewModel
    
    // MARK: - Properties
    
    var viewModel: PhotosViewModel!
    
    private let disposeBag = DisposeBag()
    
    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    /// Create and customize photosCollectionView lazily.
    private lazy var photosCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(UINib(nibName: Constants.NibFilesNames.photoCollectionViewCell, bundle: nil),
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor=UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(activityIndicator)
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        setPhotosCollectionViewItemSize(with: view.frame.size)
        
        configure(with: viewModel)
        addViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // The item size of the collection should be changed whenever the device rotates.
        setPhotosCollectionViewItemSize(with: size)
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: PhotosViewModel) {
        
        // View Model outputs to the View Controller
        
        // Set the title.
        viewModel.output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // Bind `photos` from view model to photosCollectionView. Once the data is loaded we'll hide the refresh control.
        viewModel.output.photos
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.activityIndicator.stopAnimating() })
            .bind(to: photosCollectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.reuseIdentifier, cellType: PhotoCollectionViewCell.self)) { _, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
        
        // Notify the view model that the view controller did load.
        viewModel.input.viewDidLoad.onNext(())
        
        // Bind valueChanged of refreshControl to reload Observer of view model.
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        // Handle photosCollectionView item selection and bind it to selectPhoto Observable from view model.
        // We will also give the selected a hero id to be used in animating the display of photo details.
        photosCollectionView.rx.modelSelected(PhotoViewModel.self)
            .do(onNext: { [weak self] photoViewModel in
                if let selectedItemIndexPath = self?.photosCollectionView.indexPathsForSelectedItems?.first {
                    self?.photosCollectionView.deselectItem(at: selectedItemIndexPath, animated: true)
                    self?.photosCollectionView.cellForItem(at: selectedItemIndexPath)?.hero.id = String(photoViewModel.id)
                }
            })
            .bind(to: viewModel.input.selectPhoto)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    
    /// Add subviews to the view.
    private func addViews() {
        view.addSubview(photosCollectionView)
        setupConstraints()
        view.layoutIfNeeded()
        activityIndicator.center = CGPoint(x: photosCollectionView.frame.width / 2,
                                           y: activityIndicator.frame.height / 2 + 5)
    }
    
    /// Setup the constraints of each subview.
    private func setupConstraints() {
        setupPhotosCollectionViewConstraints()
    }
    
    /// Setup the constraints of photosCollectionView.
    private func setupPhotosCollectionViewConstraints() {
        photosCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photosCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    /// Set the suitable item size of photosCollectionView.
    private func setPhotosCollectionViewItemSize(with size: CGSize) {
        if let flowLayout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = photosCollectionViewItemSize(for: size)
        }
    }

    /// Returns the suitable item size for photosCollectionView based on curren device orientation.
    ///
    /// - Parameter size: parent view size.
    /// - Returns: The suitable item size.
    private func photosCollectionViewItemSize(for size: CGSize) -> CGSize {
        return size.height > size.width ?
            photosCollectionViewPortraitItemSize(for: size) :
            photosCollectionViewLandscapeItemSize(for: size)
    }

    /// Returns the suitable item size for Portrait mode.
    private func photosCollectionViewPortraitItemSize(for size: CGSize) -> CGSize {
        return CGSize(width: size.width / 4 - 1, height: size.width / 4 - 1)
    }
    
    /// Returns the suitable item size for Landscape mode.
    private func photosCollectionViewLandscapeItemSize(for size: CGSize) -> CGSize {
        return CGSize(width: size.width / 6 - 1, height: size.width / 6 - 1)
    }
}
