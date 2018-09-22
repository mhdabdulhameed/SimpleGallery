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
    
    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    private lazy var albumsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UINib(nibName: Constants.NibFilesNames.albumTableViewCell, bundle: nil),
                           forCellReuseIdentifier: AlbumTableViewCell.reuseIdentifier)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Albums"
        
        refreshControl.sendActions(for: .valueChanged)
        
        configure(with: viewModel)
        addViews()
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: AlbumsViewModel) {
        
        // View Model outputs to the View Controller
        
        viewModel.output.albums
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: albumsTableView.rx.items(cellIdentifier: AlbumTableViewCell.reuseIdentifier, cellType: AlbumTableViewCell.self)) { _, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
        
        viewModel.input.viewDidLoad.onNext(())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        albumsTableView.rx.modelSelected(AlbumViewModel.self)
            .do(onNext: { [weak self] _ in
                if let selectedRowIndexPath = self?.albumsTableView.indexPathForSelectedRow {
                    self?.albumsTableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .bind(to: viewModel.input.selectAlbum)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    
    /// Add subviews to the view.
    private func addViews() {
        view.addSubview(albumsTableView)
        setupConstraints()
        view.layoutIfNeeded()
    }
    
    /// Setup the constraints of each subview.
    private func setupConstraints() {
        setupAlbumsTableViewConstraints()
    }
    
    /// Setup the constraints of albumsTableView.
    private func setupAlbumsTableViewConstraints() {
        albumsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        albumsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        albumsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        albumsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
