//
//  FavoriteCollectionViewCell.swift
//  UnsplashFoto
//
//  Created by Владислав on 12.02.2024.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let photoImageViewTopSpacing: CGFloat = 14.0
        static let photoImageViewLeadingSpacing: CGFloat = 10.0
        static let photoImageViewSize: CGFloat = 28.0
        static let authorNameLabelTopSpacing: CGFloat = 20.0
        static let authorNameLabelLeadingSpacing: CGFloat = 14.0
        static let downloadsLabelTopSpacing: CGFloat = 10.0
        static let downloadsLabelLeadingSpacing: CGFloat = 14.0
        static let favoriteButtonTrailingSpacing: CGFloat = 14.0
        static let favoriteButtonHeightSize: CGFloat = 28.0
    }
    
    var favoriteButtonAction: (() -> Void)?
    
    //MARK: - UI
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    let authorNameLabel = UILabel(text: "Author Name", font: .robotoBold16(), textColor: .white)
    let downloadsLabel = UILabel(text: "Downloads: 10", font: .robotoMedium16(), textColor: .white)
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        addSubview(authorNameLabel)
        addSubview(downloadsLabel)
        addSubview(favoriteButton)
    }
    
    @objc private func favoriteButtonTapped() {
        favoriteButtonAction?()
    }
}

//MARK: - setConstraints
private extension FavoriteCollectionViewCell {
    func setConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.photoImageViewTopSpacing),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.photoImageViewLeadingSpacing),
            photoImageView.heightAnchor.constraint(equalToConstant: Constants.photoImageViewSize),
            photoImageView.widthAnchor.constraint(equalToConstant: Constants.photoImageViewSize),
            
            authorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.authorNameLabelTopSpacing),
            authorNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: Constants.authorNameLabelLeadingSpacing),
            
            downloadsLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: Constants.downloadsLabelTopSpacing),
            downloadsLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: Constants.downloadsLabelLeadingSpacing),
            
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.favoriteButtonTrailingSpacing),
            favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constants.favoriteButtonHeightSize)
        ])
    }
}
