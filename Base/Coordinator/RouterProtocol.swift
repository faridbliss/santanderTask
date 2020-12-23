//
//  RouterProtocol.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import UIKit

public typealias NavigationClosure = (() -> ())

protocol RouterProtocol: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationClosure?)

    func present(_ drawable: Drawable,
                 isAnimated: Bool,
                 onDismissed closure: NavigationClosure?)

    func presentAsBottomSheet(_ drawable: Drawable,
                              preferredHeight: CGFloat,
                              isAnimated: Bool,
                              presentOnNavigationVisibleController: Bool,
                              shouldDismissOnBackgroundTap: Bool,
                              dismissOnDraggingDownSheet: Bool,
                              onDismissed closure: NavigationClosure?)
}
