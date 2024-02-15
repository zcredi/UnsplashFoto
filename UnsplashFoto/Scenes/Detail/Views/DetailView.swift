//
//  DetailView.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import UIKit

final class DetailView: UIView {
    enum Constants {
        static let favoriteButtonSize: CGFloat = 28.0
        static let favoriteButtonTopSpacing: CGFloat = 16.0
        static let favoriteButtonTrailingSpacing: CGFloat = 16.0
        static let authorImageViewSize: CGFloat = 100.0
        static let authorNameLabelTopSpacing: CGFloat = 10.0
        static let photoImageViewTopSpacing: CGFloat = 30.0
        static let photoImageViewLeadingSpacing: CGFloat = 25.0
        static let photoImageViewSize: CGFloat = 120.0
        static let dateOfCreationLabelTopSpacing: CGFloat = 20.0
        static let dateOfCreationLabelLeadingSpacing: CGFloat = 15.0
        static let locationLabelTopSpacing: CGFloat = 15.0
        static let locationLabelLeadingSpacing: CGFloat = 15.0
        static let downloadsLabelTopSpacing: CGFloat = 15.0
        static let downloadsLabelLeadingSpacing: CGFloat = 15.0
    }
    
    //MARK: - UI
    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .selected)
        button.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.tintColor = UIColor.clear
        return button
    }()
    
    let authorNameLabel = UILabel(text: "Name", font: .robotoBold16(), textColor: .white)
    let dateOfCreationLabel = UILabel(text: "Date: 11.02.24", font: .robotoMedium16(), textColor: .white)
    let locationLabel = UILabel(text: "Location: Moscow", font: .robotoMedium16(), textColor: .white)
    let downloadsLabel = UILabel(text: "Downloads: 10", font: .robotoMedium16(), textColor: .white)
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        authorImageView.layer.masksToBounds = true
    }
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .primaryDark
        layer.cornerRadius = 10
        addSubview(favoriteButton)
        addSubview(authorImageView)
        addSubview(authorNameLabel)
        addSubview(photoImageView)
        addSubview(dateOfCreationLabel)
        addSubview(locationLabel)
        addSubview(downloadsLabel)
    }
}

//MARK: - setConstraints()
extension DetailView {
    func setConstraints() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        dateOfCreationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.favoriteButtonTopSpacing),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.favoriteButtonTrailingSpacing),
            favoriteButton.heightAnchor.constraint(equalToConstant: Constants.favoriteButtonSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: Constants.favoriteButtonSize),
            
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: -Constants.authorImageViewSize / 2),
            authorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: Constants.authorImageViewSize),
            authorImageView.widthAnchor.constraint(equalToConstant: Constants.authorImageViewSize),
            
            authorNameLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: Constants.authorNameLabelTopSpacing),
            authorNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            photoImageView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: Constants.photoImageViewTopSpacing),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.photoImageViewLeadingSpacing),
            photoImageView.heightAnchor.constraint(equalToConstant: Constants.photoImageViewSize),
            photoImageView.widthAnchor.constraint(equalToConstant: Constants.photoImageViewSize),
            
            dateOfCreationLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Constants.dateOfCreationLabelTopSpacing),
            dateOfCreationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.dateOfCreationLabelLeadingSpacing),
            
            locationLabel.topAnchor.constraint(equalTo: dateOfCreationLabel.bottomAnchor, constant: Constants.locationLabelTopSpacing),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.locationLabelLeadingSpacing),
            
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.downloadsLabelTopSpacing),
            downloadsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.downloadsLabelLeadingSpacing)
        ])
    }
}
