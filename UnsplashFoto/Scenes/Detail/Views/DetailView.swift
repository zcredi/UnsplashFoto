//
//  DetailView.swift
//  UnsplashFoto
//
//  Created by Владислав on 11.02.2024.
//

import UIKit

final class DetailView: UIView {
    enum Constants {
        static let authorImageViewSize: CGFloat = 100.0
        static let authorNameLabelTopSpacing: CGFloat = 10.0
        static let dateOfCreationLabelTopSpacing: CGFloat = 10.0
        static let dateOfCreationLabelLeadingSpacing: CGFloat = 15.0
        static let locationLabelTopSpacing: CGFloat = 10.0
        static let locationLabelLeadingSpacing: CGFloat = 15.0
        static let downloadsLabelTopSpacing: CGFloat = 10.0
        static let downloadsLabelLeadingSpacing: CGFloat = 15.0
    }
    
    //MARK: - UI
    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
    
    private func setupViews() {
        backgroundColor = .primaryDark
        layer.cornerRadius = 10
        addSubview(authorImageView)
        addSubview(authorNameLabel)
        addSubview(dateOfCreationLabel)
        addSubview(locationLabel)
        addSubview(downloadsLabel)
    }
}

//MARK: - setConstraints()
private extension DetailView {
    func setConstraints() {
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfCreationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: -Constants.authorImageViewSize / 2),
            authorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: Constants.authorImageViewSize),
            authorImageView.widthAnchor.constraint(equalToConstant: Constants.authorImageViewSize),
            
            authorNameLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: Constants.authorNameLabelTopSpacing),
            authorNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dateOfCreationLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: Constants.dateOfCreationLabelTopSpacing),
            dateOfCreationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.dateOfCreationLabelLeadingSpacing),
            
            locationLabel.topAnchor.constraint(equalTo: dateOfCreationLabel.bottomAnchor, constant: Constants.locationLabelTopSpacing),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.locationLabelLeadingSpacing),
            
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.downloadsLabelTopSpacing),
            downloadsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.downloadsLabelLeadingSpacing)
        ])
    }
}
