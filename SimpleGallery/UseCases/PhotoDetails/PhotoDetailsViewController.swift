//
//  PhotoDetailsViewController.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/22/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PhotoDetailsViewController: UIViewController, ViewControllerType {
    typealias ViewModelType = PhotoDetailsViewModel
    
    // MARK: - Properties
    
    var viewModel: PhotoDetailsViewModel!
    
    private let disposeBag = DisposeBag()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(with: viewModel)
        addViews()
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: PhotoDetailsViewModel) {
        
    }
    
    // MARK: - Private Methods
    
    /// Add subviews to the view.
    private func addViews() {
        view.addSubview(photoImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupPhotoImageViewConstraints()
    }
    
    private func setupPhotoImageViewConstraints() {
        photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
