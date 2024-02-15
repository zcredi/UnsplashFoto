//
//  DetailViewController.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayPhotoDetails(_ viewModel: DetailViewModel)
    func showAlert(isFavorite: Bool)
}

final class DetailViewController: UIViewController, DetailDisplayLogic {
    enum Constants {
        static let detailViewTopSpacing: CGFloat = 80.0
        static let detailViewSideSpacing: CGFloat = 20.0
        static let detailViewHeightSpacing: CGFloat = 370.0
    }
    
    private let interactor: DetailBusinessLogic
    private var id: String?
    private let detailView = DetailView()
    
    //MARK: - init(_:)
    init(
        interactor: DetailBusinessLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        detailView.favoriteButton.addTarget(self, action: #selector(tappedFavoriteButton), for: .touchUpInside)
        interactor.viewDidLoad()
        setupCustomBackButton()
    }
    
    private func setupViews() {
        title = "Детальная информация"
        view.backgroundColor = .primarySoft
        view.addSubview(detailView)
    }
    
    func displayPhotoDetails(_ viewModel: DetailViewModel) {
        self.id = viewModel.modelId
        detailView.authorImageView.loadImage(from: viewModel.profilImage)
        detailView.authorNameLabel.text = viewModel.name
        detailView.photoImageView.loadImage(from: viewModel.imageUrl)
        detailView.dateOfCreationLabel.text = ("Дата создания: \(formatDateString(viewModel.createdAt)) года")
        let locationText = viewModel.location.isEmpty ? "Не указано" : viewModel.location
        detailView.locationLabel.text = ("Город: \(locationText)")
        detailView.downloadsLabel.text = ("Скачали: \(viewModel.downloads) раз")
        detailView.favoriteButton.isSelected = viewModel.isFavorite
    }
    
    @objc private func tappedFavoriteButton() {
        let isAddingToFavorites = !detailView.favoriteButton.isSelected
        self.id.flatMap { interactor.didTapFavoriteButton($0, isAddingToFavorites: isAddingToFavorites) }
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

//MARK: - Formatter Date
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

//MARK: - Alert
extension DetailViewController {
    func showAlert(isFavorite: Bool) {
        let message = isFavorite ? "Добавлено в избранное" : "Удалено из избранного"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
