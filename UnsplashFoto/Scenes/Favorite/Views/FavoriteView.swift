//
//  FavoriteView.swift
//  UnsplashFoto
//
//  Created by Владислав on 12.02.2024.
//

import UIKit

final class FavoriteView: UIView {
    enum Constants {
        static let idFavoriteCell: String = "idFavoriteCell"
    }
    
    //MARK: - UI
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - init(_:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idFavoriteCell)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .primarySoft
        addSubview(collectionView)
    }
}

//MARK: - setConstraints()
private extension FavoriteView {
    private func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
