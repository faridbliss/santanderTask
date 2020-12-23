//
//  Router.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import UIKit
import RxSwift
import MaterialComponents.MaterialBottomSheet

public enum RouterFlowType {
    case present
    case push
    case bottomSheet
}

public class Router: NSObject, RouterProtocol {

    public var flowType: RouterFlowType = .push
    private let shouldHideBackButton: Bool = false

    let navigationController: UINavigationController
    private var closures: [String: NavigationClosure] = [:]

    public init(navigationController: UINavigationController,
                flowType: RouterFlowType = .push,
                shouldHideBackButton: Bool = false) {

        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    public func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationClosure?) {
        guard let viewController = drawable.viewController else {
            return
        }

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }

    public func present(_ drawable: Drawable,
                        isAnimated: Bool,
                        onDismissed closure: NavigationClosure?) {
        guard let viewController = drawable.viewController else {
            return
        }

        viewController.presentationController?.delegate = self

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }

        navigationController.present(viewController, animated: isAnimated)
    }

    func presentAsBottomSheet(_ drawable: Drawable,
                              preferredHeight: CGFloat,
                              isAnimated: Bool,
                              presentOnNavigationVisibleController: Bool,
                              shouldDismissOnBackgroundTap: Bool = true,
                              dismissOnDraggingDownSheet: Bool = false,
                              onDismissed closure: NavigationClosure?) {

        guard let viewController = drawable.viewController else {
            return
        }

        let bottomSheetController = bottomSheet(viewControllerToPresent: viewController,
                                                withHeight: preferredHeight,
                                                shouldDismissOnBackgroundTap: shouldDismissOnBackgroundTap,
                                                dismissOnDraggingDownSheet: dismissOnDraggingDownSheet)

        if let closure = closure {
            closures.updateValue(closure, forKey: bottomSheetController.description)
        }

        navigationController.present(bottomSheetController, animated: isAnimated)
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }

    private func bottomSheet(viewControllerToPresent: UIViewController,
                             withHeight preferredHeight: CGFloat,
                             shouldDismissOnBackgroundTap: Bool = false,
                             dismissOnDraggingDownSheet: Bool = false) -> MDCBottomSheetController {
        let bottomSheetController = MDCBottomSheetController(contentViewController: viewControllerToPresent)
        let shapeGenerator = MDCCurvedRectShapeGenerator(cornerSize: CGSize(width: 10, height: 10))
        bottomSheetController.setShapeGenerator(shapeGenerator, for: .preferred)
        bottomSheetController.setShapeGenerator(shapeGenerator, for: .extended)
        bottomSheetController.setShapeGenerator(shapeGenerator, for: .closed)

        bottomSheetController.dismissOnDraggingDownSheet = dismissOnDraggingDownSheet
        bottomSheetController.dismissOnBackgroundTap = shouldDismissOnBackgroundTap
        bottomSheetController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: preferredHeight)

        return bottomSheetController
    }
}

extension Router: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(presentationController.presentedViewController)
    }
}

extension Router: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }

    public func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {

        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

extension Reactive where Base: Router {

    public func push(_ drawable: Drawable, isAnimated: Bool) -> Observable<Void> {
        return Observable.create({ [weak base] observer -> Disposable in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }

            base.push(drawable, isAnimated: isAnimated, onNavigateBack: {
                observer.onNext(())
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    public func present(_ drawable: Drawable, isAnimated: Bool) -> Observable<Void> {
        return Observable.create({ [weak base] observer -> Disposable in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }

            base.present(drawable, isAnimated: isAnimated, onDismissed: {
                observer.onNext(())
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    public func presentAsBottomSheet(_ drawable: Drawable,
                                     preferredHeight: CGFloat,
                                     isAnimated: Bool,
                                     shouldDismissOnBackgroundTap: Bool = true,
                                     dismissOnDraggingDownSheet: Bool = false,
                                     presentOnNavigationVisibleController: Bool = false) -> Observable<Void> {

        return Observable.create({ [weak base] observer -> Disposable in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }

            base.presentAsBottomSheet(drawable,
                                      preferredHeight: preferredHeight,
                                      isAnimated: isAnimated,
                                      presentOnNavigationVisibleController: presentOnNavigationVisibleController,
                                      shouldDismissOnBackgroundTap: shouldDismissOnBackgroundTap,
                                      dismissOnDraggingDownSheet: dismissOnDraggingDownSheet,
                                      onDismissed: {

                observer.onNext(())
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    public func navigate(to controller: UIViewController, bottomSheetPreferredHeight: CGFloat = 0.0) -> Observable<Void> {
        switch base.flowType {
        case .present:
            return present(controller, isAnimated: true)
        case .push:
            return push(controller, isAnimated: true)
        case .bottomSheet:
            return presentAsBottomSheet(controller, preferredHeight: bottomSheetPreferredHeight, isAnimated: true)
        }
    }
}

