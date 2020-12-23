//
//  EmptyView.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import UIKit
import SnapKit
import Resources
import AppConstants

public class EmptyView: BaseView {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel =  {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    public var titleText = "" {
        didSet {
            titleLabel.text = titleText
        }
    }

    public var subtitleText = "" {
        didSet {
            subtitleLabel.text = subtitleText
        }
    }

    public var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    var startingYPosition: Int?

    public init(with buttons: [UIButton]? = nil, startingYPosition: Int? = nil, extraViewsToAdd: [UIView]? = nil) {
        self.startingYPosition = startingYPosition
        super.init()

        if let extraViewsToAdd = extraViewsToAdd {
            extraViewsToAdd.forEach { view in
                stackView.addArrangedSubview(view)
            }
        }
        buttons?.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    required init() {
        super.init()
    }

    override public func setupSubviews() {
        super.setupSubviews()
        titleLabel.font = R.font.robotoBold(size: 18)

        subtitleLabel.font = R.font.robotoRegular(size: 14)

    }
    override public func setupColorsAndStyles() {
        super.setupColorsAndStyles()
        titleLabel.textColor = AppConstants.Colors.textDefaultColor
        subtitleLabel.textColor =  AppConstants.Colors.textDefaultColor
    }
    override public func addSubviews() {
        super.addSubviews()
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }

    override public func setupAutoLayout() {
        super.setupAutoLayout()
        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(56)
            make.leading.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
            if let startingYPosition = startingYPosition {
                make.top.equalTo(startingYPosition)
            } else {
                make.centerY.equalToSuperview()
            }
        }

        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(130)
        }
    }

}

