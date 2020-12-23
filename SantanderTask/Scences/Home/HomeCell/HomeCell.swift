//
//  HomeCell.swift
//  SantanderTask
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import Foundation
import UIKit
import UIComponents
import Resources
import Base

class HomeCollectionCell: CollectionCell {
    private let lbleName = UIFactory.label()
    private let imageView = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }
    private let stackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 5
    }

    override func setupSubviews() {
        super.setupSubviews()

    }
    override func addSubviews() {
        super.addSubviews()
       addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(lbleName)
    }
    override func setupAutoLayout() {
        super.setupAutoLayout()
        stackView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
    }

    func configureCell(text: String, url: String) {
        let numStr = url.components(separatedBy: "/").dropLast()
        imageView.image(with: R.string.base.pokemonImageUrl(Int(numStr.last ?? "0")!),
                        shouldHideOnError: false,
                        placeHolderImage: UIColor.gray.image())
        lbleName.text = text
    }

}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 200, height: 200)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
