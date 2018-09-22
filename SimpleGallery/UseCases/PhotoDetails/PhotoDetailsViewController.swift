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
    
    private lazy var doneBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
    }()
    
    private lazy var analyzeBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Analyze", style: .plain, target: nil, action: nil)
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = doneBarButtonItem
        navigationItem.rightBarButtonItem = analyzeBarButtonItem
        
        doneBarButtonItem.rx.tap
            .subscribe { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        configure(with: viewModel)
        addViews()
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: PhotoDetailsViewModel) {
        
        // View Model outputs to the View Controller
        
        viewModel.output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.output.photoUrl
            .subscribe(onNext: { [photoImageView] url in
                SDWebImageHelper.setImage(for: photoImageView, from: url)
            })
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
    }
    
    // MARK: - Private Methods
    
    /// Add subviews to the view.
    private func addViews() {
        view.addSubview(photoImageView)
        setupConstraints()
        view.layoutIfNeeded()
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
