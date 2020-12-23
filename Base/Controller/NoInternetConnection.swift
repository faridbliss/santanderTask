//
//  NoInternetConnection.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import UIKit
import RxSwift
import RxCocoa
import Resources
import AppConstants
public class NoInternetConnectionView: EmptyView {

    private var disposeBag = DisposeBag()

    public var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.base.tryAgainButton(), for: .normal)
        button.backgroundColor = AppConstants.Colors.defaultColor
        button.titleLabel?.font = R.font.robotoBold(size: 12)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    public required init() {
        super.init(with: [retryButton], startingYPosition: nil, extraViewsToAdd: nil)
        titleText = R.string.base.connectivityIssues()
        subtitleText = R.string.base.connectivityIssuesMeassage()
        image = R.image.img_no_internet_connection()!
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        retryButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(34)
        }
        retryButton.layer.cornerRadius = 4
    }

    public override func bindUI() {
        super.bindUI()
        retryButton.rx.tap.bind(onNext: { [weak self] _ in
            self?.isHidden = true
        }).disposed(by: disposeBag)
    }
}

