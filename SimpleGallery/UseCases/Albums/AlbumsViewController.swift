//
//  AlbumsViewController.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

final class AlbumsViewController: UIViewController, ViewControllerType {
    typealias ViewModelType = AlbumsViewModel
    
    // MARK: - Properties
    
    var viewModel: AlbumsViewModel!
    
    private lazy var albumsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(with: viewModel)
        addViews()
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: AlbumsViewModel) {
        
    }
    
    // MARK: - Private Methods
    
    private func addViews() {
        view.addSubview(albumsTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupAlbumsTableViewConstraints()
    }
    
    private func setupAlbumsTableViewConstraints() {
        albumsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        albumsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        albumsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        albumsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
