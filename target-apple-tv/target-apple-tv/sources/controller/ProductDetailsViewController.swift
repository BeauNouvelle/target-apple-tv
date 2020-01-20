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

    private let productCode: String
    private var productDetails: ProductDetails? {
        didSet {
            DispatchQueue.main.async {
                let color: String = self.traitCollection.userInterfaceStyle == .dark ? "white" : "black"
                let featuresString = "<font color=\(color) face='-apple-system' size='24'>\(self.productDetails?.product.description ?? "")<br><br>"
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
        firstVerticalStackView.addArrangedSubview(productImagesCollectionView)

        horizontalStackView.addArrangedSubview(firstVerticalStackView)
        horizontalStackView.addArrangedSubview(textView)

        textView.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.indirect.rawValue)]
        textView.isScrollEnabled = true
        textView.bounces = true
        textView.isUserInteractionEnabled = true
        textView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width/2)
        }
    }

    private func loadData() {
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
