//
//  TableCell.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import UIKit
import RxSwift

open class TableCell: UITableViewCell {
    public var disposeBag = DisposeBag()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
        addSubviews()
        setupAutoLayout()
        setupColorsAndStyles()
        bindUI()
        selectionStyle = .none
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    open func setupSubviews() {}

    open func addSubviews() {}

    open func setupAutoLayout() {}

    open func setupColorsAndStyles() {}

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

