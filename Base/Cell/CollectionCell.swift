//
//  CollectionCell.swift
//  Base
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import RxSwift

open class CollectionCell: UICollectionViewCell {

     static var reuseIdentifier: String {
         return String(describing: self)
     }

    public var disposeBag = DisposeBag()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupSubviews()
        addSubviews()
        setupAutoLayout()
        setupColorsAndStyles()
        bindUI()
    }

    open func setupSubviews() {}

    open func addSubviews() {}

    open func setupAutoLayout() {}

    open func setupColorsAndStyles() {
    }

    open func bindUI() {}

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupColorsAndStyles()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

