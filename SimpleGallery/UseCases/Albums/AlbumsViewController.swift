//
//  AlbumsViewController.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AlbumsViewController: UIViewController, ViewControllerType {
    typealias ViewModelType = AlbumsViewModel
    
    // MARK: - Properties
    
    var viewModel: AlbumsViewModel!
    
    private let disposeBag = DisposeBag()
    
    private var albumsCollectionViewItemSize: CGSize {
        return CGSize(width: view.frame.width / 4 - 1, height: view.frame.width / 4 - 1)
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    /// Create and customize albumsTableView lazily.
    private lazy var albumsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UINib(nibName: Constants.NibFilesNames.albumTableViewCell, bundle: nil),
                           forCellReuseIdentifier: AlbumTableViewCell.reuseIdentifier)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        return tableView
    }()
    
    /// Create and customize albumsCollectionView lazily.
    private lazy var albumsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.itemSize = albumsCollectionViewItemSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(UINib(nibName: Constants.NibFilesNames.albumCollectionViewCell, bundle: nil),
                                forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor=UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Albums"
        
        refreshControl.sendActions(for: .valueChanged)
        
        configure(with: viewModel)
        addViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // albumsCollectionView will be shown in all cases were the current screen is considered wide. In all other cases the albumsTableView will be shown.
        albumsTableView.isHidden = UIKitUtils.isWideScreen()
        albumsCollectionView.isHidden = !UIKitUtils.isWideScreen()
        
        if let flowLayout = albumsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = albumsCollectionViewItemSize
        }
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: AlbumsViewModel) {
        
        // View Model outputs to the View Controller
        
        
        // Bind `albums` from view model to albumsTableView. Once the data is loaded we'll hide the refresh control.
        viewModel.output.albums
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: albumsTableView.rx.items(cellIdentifier: AlbumTableViewCell.reuseIdentifier, cellType: AlbumTableViewCell.self)) { _, item, cell in
                cell.accessoryType = .disclosureIndicator
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        // Bind `albums` from view model to albumsCollectionView. Once the data is loaded we'll hide the refresh control.
        viewModel.output.albums
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: albumsCollectionView.rx.items(cellIdentifier: AlbumCollectionViewCell.reuseIdentifier, cellType: AlbumCollectionViewCell.self)) { _, item, cell in
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
        
        // Handle albumsTableView item selection and bind it to selectAlbum Observable from view model.
        albumsTableView.rx.modelSelected(AlbumViewModel.self)
            .do(onNext: { [weak self] _ in
                if let selectedRowIndexPath = self?.albumsTableView.indexPathForSelectedRow {
                    self?.albumsTableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .bind(to: viewModel.input.selectAlbum)
            .disposed(by: disposeBag)
        
        // Handle albumsCollectionView item selection and bind it to selectAlbum Observable from view model.
        albumsCollectionView.rx.modelSelected(AlbumViewModel.self)
            .do(onNext: { [weak self] _ in
                if let selectedItemIndexPath = self?.albumsCollectionView.indexPathsForSelectedItems?.first {
                    self?.albumsCollectionView.deselectItem(at: selectedItemIndexPath, animated: true)
                }
            })
            .bind(to: viewModel.input.selectAlbum)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    
    /// Add subviews to the view.
    private func addViews() {
        view.addSubview(albumsTableView)
        view.addSubview(albumsCollectionView)
        setupConstraints()
        view.layoutIfNeeded()
    }
    
    /// Setup the constraints of each subview.
    private func setupConstraints() {
        setupAlbumsTableViewConstraints()
        setupAlbumsCollectionViewConstraints()
    }
    
    /// Setup the constraints of albumsTableView.
    private func setupAlbumsTableViewConstraints() {
        albumsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        albumsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        albumsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        albumsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Setup the constraints of albumsCollectionView.
    private func setupAlbumsCollectionViewConstraints() {
        albumsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        albumsCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        albumsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        albumsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
