//
//  FavoriteViewController.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

protocol DisplayFavoritesLogic {
    func displayFavorites(_ favorites: [FavoriteViewModel])
}

final class FavoriteViewController: UIViewController, DisplayFavoritesLogic {
    
    private let favoriteView = FavoriteView()
    private var favoriteViewModels = [FavoriteViewModel]()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        print(favoriteViewModels)
    }
    
    private func setupViews() {
        view.addSubview(favoriteView)
    }
    
    private func setDelegates() {
        favoriteView.collectionView.delegate = self
        favoriteView.collectionView.dataSource = self
        //        favoriteView.delegate = self
    }
    
    func displayFavorites(_ favorites: [FavoriteViewModel]) {
        DispatchQueue.main.async {
            self.favoriteViewModels = favorites
            self.favoriteView.collectionView.reloadData()
        }
    }
    
    private func loadFavorites() {
        let favorites = FavoritesManager.shared.getFavorites().map { favoritePhoto in
            FavoriteViewModel(id: favoritePhoto.id!,
                                     authorName: favoritePhoto.authorName!,
                                     imageUrl: favoritePhoto.imageUrl!,
                                     downloads: favoritePhoto.downloadCount!)
               }
        DispatchQueue.main.async {
        self.favoriteViewModels = favorites
        self.favoriteView.collectionView.reloadData()
        }
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
        favoriteViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteView.Constants.idFavoriteCell, for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell() }
        
        let viewModel = favoriteViewModels[indexPath.row]
            cell.authorNameLabel.text = viewModel.authorName
            cell.downloadsLabel.text = "Downloads: \(viewModel.downloads)"
            cell.photoImageView.loadImage(from: viewModel.imageUrl)
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
