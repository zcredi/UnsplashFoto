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
    let router: MainRoutingLogic
    
    var mainView = MainView()
    var photoViewModels = [PhotoViewModel]()
    var filteredViewModels = [PhotoViewModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - init(_:)
    init(router: MainRoutingLogic) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        setupSearchController()
        fetchRandomPhotoData()
        setupTapGesture()
    }
    
    private func fetchRandomPhotoData() {
        interactor?.fetchRandomPhotos()
        mainView.endRefreshing()
    }
    
    private func setupViews() {
        title = "Главная"
        view.backgroundColor = .primarySoft
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = .lightGray
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        }
    }
    
    @objc private func dismissKeyboard() {
        if searchController.isActive {
            searchController.isActive = false
        } else {
            view.endEditing(true)
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
        return searchController.isActive ? filteredViewModels.count : photoViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainView.Constants.idMainCell, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let viewModel = searchController.isActive ? filteredViewModels[indexPath.row] : photoViewModels[indexPath.row]
        cell.configure(with: viewModel.imageUrl)
        
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
        searchController.isActive = false
        router.routeToDetail(with: selectedPhoto)
    }
}

//MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
    func refreshDataForCoinView(_ mainView: MainView) {
        fetchRandomPhotoData()
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredViewModels = photoViewModels
            mainView.collectionView.reloadData()
            return
        }
        
        filteredViewModels = photoViewModels.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        mainView.collectionView.reloadData()
    }
}

//MARK: - Tap Gesture
private extension MainViewController {
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}
