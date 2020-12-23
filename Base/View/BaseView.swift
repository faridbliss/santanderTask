//
//  BaseView.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//
import Foundation
import UIKit
import RxSwift

open class BaseView: UIView {
    public typealias OriginalConstraintConstant = CGFloat
    // place here all views that you want to move when keyboard appears or disappears
    // the view's y position you increase when keyboard appears and decrease when it disappears
    // NOTE: !!! THIS WILL ONLY WORKS IF YOU SET YOUR BOTTOM CONSTRAINTS EQUAL TO SAFEAREALAYOUTGUIDE !!!
    public var viewsToUpdatePositionWhenKeyboardChanges: [UIView: OriginalConstraintConstant] = [:]

    // NOTE: If the animate in `updateSubviewsConstraintsToReflectKeyboardState` is called in viewWillAppear with animation
    // `layoutIfNeeded` we have an animation glitch so this variable was added to control this scenario
    // ideally, we have to find a better solution for this case
    var didAppeared: Bool = false

    required public init() {
        super.init(frame: CGRect.zero)

        setupSubviews()
        addSubviews()
        setupAutoLayout()
        setViewsToUpdatesWhenKeyboardsChanges()
        setupColorsAndStyles()
        bindUI()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("You should not be using Interface builder ;)")
    }

    open func setupSubviews() {}

    open func addSubviews() {}

    open func setupAutoLayout() {}

    open func bindUI() {}

    open func setupColorsAndStyles() {
        backgroundColor = .white
    }

    open func setViewsToUpdatesWhenKeyboardsChanges() {}

    open  func updateSubviewsConstraintsToReflectKeyboardState(_ keyboardVisibleHeight: CGFloat) {
       viewsToUpdatePositionWhenKeyboardChanges.forEach { view, originalConstraint in
                UIView.animate(withDuration: 0.5, animations: {
                    view.snp.updateConstraints { make in
                        var decreaseValue: CGFloat = 0
                        if keyboardVisibleHeight > 0 {
                            decreaseValue = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
                        }
                        make.bottom.equalTo(self.safeAreaLayoutGuide).inset(keyboardVisibleHeight + originalConstraint - decreaseValue)
                    }
                })
                if didAppeared { self.layoutIfNeeded() }
            }
    }

}
