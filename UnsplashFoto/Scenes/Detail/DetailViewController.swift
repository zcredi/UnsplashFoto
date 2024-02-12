//
//  DetailViewController.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayPhotoDetails(_ viewModel: DetailViewModel)
}

final class DetailViewController: UIViewController, DetailDisplayLogic {
    enum Constants {
        static let detailViewTopSpacing: CGFloat = 80.0
        static let detailViewSideSpacing: CGFloat = 20.0
        static let detailViewHeightSpacing: CGFloat = 370.0
    }
    
    var presenter: DetailPresentationLogic?
    
    private let detailView = DetailView()
    var photo: UnsplashPhoto?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .primarySoft
        view.addSubview(detailView)
    }
    
    func displayPhotoDetails(_ viewModel: DetailViewModel) {
        detailView.authorImageView.loadImage(from: viewModel.profilImage)
        detailView.authorNameLabel.text = viewModel.name
        detailView.photoImageView.loadImage(from: viewModel.imageUrl)
        detailView.dateOfCreationLabel.text = ("Дата создания: \(formatDateString(viewModel.createdAt)) года")
        let locationText = viewModel.location.isEmpty ? "Не указано" : viewModel.location
        detailView.locationLabel.text = ("Город: \(locationText)")
        detailView.downloadsLabel.text = ("Скачали: \(viewModel.downloads) раз")
    }
}

private extension DetailViewController {
    func setConstraints() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.detailViewTopSpacing),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.detailViewSideSpacing),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.detailViewSideSpacing),
            detailView.heightAnchor.constraint(equalToConstant: Constants.detailViewHeightSpacing)
        ])
    }
}

private extension DetailViewController {
    func formatDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM yyyy"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
