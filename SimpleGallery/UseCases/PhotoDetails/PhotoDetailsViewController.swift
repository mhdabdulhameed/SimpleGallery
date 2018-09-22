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
import Hero

final class PhotoDetailsViewController: UIViewController, ViewControllerType {
    typealias ViewModelType = PhotoDetailsViewModel
    
    // MARK: - Properties
    
    var viewModel: PhotoDetailsViewModel!
    var alertManager: AlertManager!
    
    private let disposeBag = DisposeBag()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        hero.isEnabled = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        
        configure(with: viewModel)
        addViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if UIKitUtils.isPortrait() {
            photoImageView.frame = CGRect(x: (view.bounds.width - 250) / 2,
                                          y: 140,
                                          width: 250,
                                          height: view.bounds.height - 280)
        } else {
            photoImageView.frame = CGRect(x: 140,
                                          y: (view.bounds.height - 250) / 2,
                                          width: view.bounds.width - 280,
                                          height: 250)
        }
    }
    
    // MARK: - ViewControllerType Conformation
    
    func configure(with viewModel: PhotoDetailsViewModel) {
        
        // View Model outputs to the View Controller
        
        viewModel.output.photoId
            .subscribe(onNext: { [photoImageView] photoId in
                photoImageView.hero.id = photoId
            })
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
    }
    
    @objc func onTap() {
        dismiss(animated: true)
    }
}
