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

    private var heroCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private var homeModel: HomeModel? {
        didSet {
            DispatchQueue.main.async {
                self.heroCollectionView.reloadData()
                self.categoryCollectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        loadData()
    }

    private func setupSubviews() {

        // HERO
        let heroLayout = UICollectionViewFlowLayout()
        heroLayout.scrollDirection = .horizontal
        heroLayout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)

        heroCollectionView = UICollectionView(frame: .zero, collectionViewLayout: heroLayout)

        view.addSubview(heroCollectionView)

        heroCollectionView.delegate = self
        heroCollectionView.dataSource = self
        heroCollectionView.register(cellClass: HeroItemCollectionViewCell.self)

        heroCollectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY).offset(150)
        }

        // CATEGORY
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        categoryLayout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)

        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)

        view.addSubview(categoryCollectionView)

        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(cellClass: CategoryCollectionViewCell.self)

        categoryCollectionView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(view.snp.centerY)
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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == heroCollectionView {
            return homeModel?.heroItems?.count ?? 0
        }
        return homeModel?.categoryItems?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == heroCollectionView {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == heroCollectionView, let category = homeModel?.heroItems?[indexPath.row].url?.lastPathComponent {
            let viewController = ProductListingViewController(productCategory: category)
            present(viewController, animated: true, completion: nil)
        } else if let category = homeModel?.categoryItems?[indexPath.row].url?.lastPathComponent {
            let viewController = ProductListingViewController(productCategory: category)
            present(viewController, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == heroCollectionView {
            return CGSize(width: 600, height: 400)
        }
        return CGSize(width: 250, height: 250)
    }

}
