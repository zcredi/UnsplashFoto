//
//  MainViewController.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayFetchedPhotos(_ viewModels: [PhotoViewModel])
}

final class MainViewController: UIViewController, MainDisplayLogic {
    var interactor: MainBusinessLogic?
    var router: MainRoutingLogic?
    
    var mainView = MainView()
    var photoViewModels = [PhotoViewModel]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        fetchRandomPhotoData()
        router = MainRouter(viewController: self)
    }
    
    private func fetchRandomPhotoData() {
        interactor?.fetchRandomPhotos()
        mainView.endRefreshing()
    }
    
    private func setupViews() {
        view.addSubview(mainView)
    }
    
    private func setDelegates() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.delegate = self
    }
    
    func displayFetchedPhotos(_ viewModels: [PhotoViewModel]) {
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
            self.photoViewModels = viewModels
        }
    }
}

//MARK: - setConstraints()
extension MainViewController {
    private func setConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainView.Constants.idMainCell, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let viewModel = photoViewModels[indexPath.row]
        cell.configure(with: viewModel.url)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingBetweenCells: CGFloat = 10
        let totalSpacing = spacingBetweenCells * 2
        let cellWidth = (collectionView.bounds.width - totalSpacing) / 3
        
        return CGSize(width: cellWidth, height: cellWidth) //
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.willDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.didEndDisplay()
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhoto = photoViewModels[indexPath.row]
        router?.routeToDetail(with: selectedPhoto)
    }
}

//MARK: - CoinViewDelegate
extension MainViewController: MainViewDelegate {
    func refreshDataForCoinView(_ coinView: MainView) {
        fetchRandomPhotoData()
    }
}
