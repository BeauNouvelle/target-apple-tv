//
//  SearchViewController.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 21/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {

    private var searchTerm: String?

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    var productListing: ProductListing? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        loadData()
    }

    private func setupSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.addSubview(collectionView)

        collectionView.register(cellClass: ProductCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    private func loadData() {
        activityIndicator.startAnimating()

        ProductListingService.productListingFor(productQueryParameter: .search(query: searchTerm ?? "all")) { (result) in
            switch result {
            case .failure(let error):
                print(error.message)
            case .success(let listing):
                self.productListing = listing
            }
        }
    }

}

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListing?.products.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: ProductCollectionViewCell.self, forIndexPath: indexPath)
        let product = productListing?.products[indexPath.row]
        cell.imageView.kf.setImage(with: product?.primaryImageUrl)
        cell.titleLabel.text = product?.name

        cell.tagLabel.text = product?.badge?.name
        cell.tagLabel.textColor = product?.badge?.textColor

        cell.priceLabel.text = product?.formattedPrice

        cell.ratingLabel.setRating(product?.averageRating ?? 0, outOf: 5)

        return cell
    }

}

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productListing?.products[indexPath.row]
        guard let code = product?.code else { return }
        let vc = ProductDetailsViewController(productCode: code)
        present(vc, animated: true, completion: nil)
    }
}