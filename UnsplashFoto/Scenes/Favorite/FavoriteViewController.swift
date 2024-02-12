//
//  FavoriteViewController.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    private let favoriteView = FavoriteView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    private func setupViews() {
        view.addSubview(favoriteView)
    }
    
    private func setDelegates() {
        favoriteView.collectionView.delegate = self
        favoriteView.collectionView.dataSource = self
        //        favoriteView.delegate = self
    }
}

//MARK: - setConstraints()
private extension FavoriteViewController {
    func setConstraints() {
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteView.Constants.idFavoriteCell, for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 7
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

//MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
