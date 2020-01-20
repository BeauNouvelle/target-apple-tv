//
//  HomeViewController.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class HomeViewController: UIViewController {

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private var homeModel: HomeModel? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        loadData()
    }

    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellClass: CategoryCollectionViewCell.self)
        collectionView.register(cellClass: HeroItemCollectionViewCell.self)

        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func loadData() {
        HomeService.homeModel { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.message)
            case .success(let homeModel):
                self?.homeModel = homeModel
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return homeModel?.heroItems?.count ?? 0
        }
        return homeModel?.categoryItems?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeue(cellClass: HeroItemCollectionViewCell.self, forIndexPath: indexPath)
            let heroItem = homeModel?.heroItems?[indexPath.row]
            cell.imageView.kf.setImage(with: heroItem?.image)
            return cell
        }
        let cell = collectionView.dequeue(cellClass: CategoryCollectionViewCell.self, forIndexPath: indexPath)
        let category = homeModel?.categoryItems?[indexPath.row]
        cell.imageView.kf.setImage(with: category?.image)
        cell.titleLabel.text = category?.title
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 570, height: 380)
        }
        return CGSize(width: 250, height: 250)
    }

}
