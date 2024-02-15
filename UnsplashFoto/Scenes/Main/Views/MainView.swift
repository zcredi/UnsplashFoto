//
//  MainView.swift
//  UnsplashFoto
//
//  Created by Владислав on 09.02.2024.
//

import Foundation

import UIKit

protocol MainViewDelegate: AnyObject {
    func refreshDataForCoinView(_ mainView: MainView)
}

final class MainView: UIView {
    enum Constants {
        static let idMainCell: String = "idMainCell"
    }
    
    weak var delegate: MainViewDelegate?
    private let refreshControl = UIRefreshControl()
    
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
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idMainCell)
        setupViews()
        setConstraints()
        addRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .none
        addSubview(collectionView)
    }
}

//MARK: - setConstraints()
private extension MainView {
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

//MARK: - RefreshControl
extension MainView {
    func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        delegate?.refreshDataForCoinView(self)
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}
