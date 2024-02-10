//
//  MainCollectionViewCell.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testPhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(mainImageView)
    }
    
    func configure(with url: String) {
        mainImageView.loadImage(from: url)
    }
}

//MARK: - setConstraints()
extension MainCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewCell
extension UICollectionViewCell {
    @objc func willDisplay() {}
    @objc func didEndDisplay() {}
}
