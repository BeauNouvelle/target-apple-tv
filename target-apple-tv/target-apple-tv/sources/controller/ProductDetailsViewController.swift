//
//  ProductDetailsViewController.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class ProductDetailsViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let productCode: String
    private var productDetails: ProductDetails? {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()

                let color: String = self.traitCollection.userInterfaceStyle == .dark ? "white" : "black"
                let title = "<font color=\(color) face='-apple-system' size='24'><h3>\(self.productDetails?.product.name ?? "")</h3>"
                self.titleLabel.attributedText = try? NSAttributedString(HTMLString: title)
                self.ratingLabel.setRating(self.productDetails?.product.averageRating ?? 0, outOf: 5)
                let description = self.productDetails?.product.description ?? ""
                let featuresString = "<font color=\(color) face='-apple-system' size='24'>\(description)<br><br>"
                self.textView.attributedText = try? NSAttributedString(HTMLString: featuresString)
            }
        }
    }

    private var productImages: [Media]? {
        didSet {
            DispatchQueue.main.async {
                self.productImagesCollectionView.reloadData()
            }
        }
    }

    private let horizontalStackView = UIStackView()
    private var productImagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let textView = UITextView()

    init(productCode: String) {
        self.productCode = productCode
        super.init(nibName: nil, bundle: nil)
    }

    @available(tvOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        loadData()
    }

    private func setupSubviews() {
        view.addSubview(horizontalStackView)
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true

        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        horizontalStackView.axis = .horizontal
        horizontalStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        productImagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        productImagesCollectionView.register(cellClass: ProductImageCollectionViewCell.self)
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self

        let firstVerticalStackView = UIStackView()
        firstVerticalStackView.axis = .vertical
        firstVerticalStackView.addArrangedSubview(ratingLabel)
        firstVerticalStackView.addArrangedSubview(productImagesCollectionView)

        ratingLabel.textColor = #colorLiteral(red: 0.9764265418, green: 0.7961158156, blue: 0.2235357463, alpha: 1)
        ratingLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        horizontalStackView.addArrangedSubview(firstVerticalStackView)
        let secondVerticalStackView = UIStackView()
        horizontalStackView.addArrangedSubview(secondVerticalStackView)
        secondVerticalStackView.axis = .vertical
        secondVerticalStackView.addArrangedSubview(titleLabel)
        secondVerticalStackView.addArrangedSubview(textView)

        titleLabel.clipsToBounds = true
        titleLabel.numberOfLines = 2
        titleLabel.font = .preferredFont(for: .headline, weight: .bold)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview().inset(20)
        }

        textView.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.indirect.rawValue)]
        textView.isScrollEnabled = true
        textView.bounces = true
        textView.isUserInteractionEnabled = true
        textView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width/2)
        }
    }

    private func loadData() {
        activityIndicator.startAnimating()

        ProductDetailsService.product(productCode: productCode) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.message)
            case .success(let details):
                self?.productImages = details.product.targetVariantProductListerData?.first?.images.filter { $0.url?.contains("/full/") == true }
                self?.productDetails = details
            }
        }
    }

}

extension ProductDetailsViewController: UICollectionViewDelegate {

}

extension ProductDetailsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: ProductImageCollectionViewCell.self, forIndexPath: indexPath)
        if let image = productImages?[indexPath.row], let path = image.url, let url = URL(string: "https://target.com.au\(path)") {
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }

}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 700, height: 700)
    }

}
