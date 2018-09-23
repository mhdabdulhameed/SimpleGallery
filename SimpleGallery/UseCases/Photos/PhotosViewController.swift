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
    
    private var photosCollectionViewPortraitItemSize: CGSize {
        return CGSize(width: view.frame.width / 4 - 1, height: view.frame.width / 4 - 1)
    }
    
    private var photosCollectionViewLandscapeItemSize: CGSize {
        return CGSize(width: view.frame.width / 6 - 1, height: view.frame.width / 6 - 1)
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
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
        
        configure(with: viewModel)
        addViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = UIKitUtils.isPortrait() ?
                photosCollectionViewPortraitItemSize : photosCollectionViewLandscapeItemSize
        }
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: PhotosViewModel) {
        
        // View Model outputs to the View Controller
        
        viewModel.output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.output.photos
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.activityIndicator.stopAnimating() })
            .bind(to: photosCollectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.reuseIdentifier, cellType: PhotoCollectionViewCell.self)) { _, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
        
        viewModel.input.viewDidLoad.onNext(())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        photosCollectionView.rx.modelSelected(PhotoViewModel.self)
            .do(onNext: { [weak self] photoViewModel in
                if let selectedItemIndexPath = self?.photosCollectionView.indexPathsForSelectedItems?.first {
                    self?.photosCollectionView.deselectItem(at: selectedItemIndexPath, animated: true)
//                    heroId = selectedItemIndexPath.item
                    self?.photosCollectionView.cellForItem(at: selectedItemIndexPath)?.hero.id = String(photoViewModel.id) // String(heroId)
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

}
