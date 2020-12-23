//
//  BaseViewController.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import UIKit
//
import RxSwift
//
import MaterialComponents
import API
import Resources
import RxKeyboard

public protocol PresentableAppError {
    var errorDescription: String? { get }
}

public protocol BaseControllerWithSupportedInterfaces {
    var supportedInterfaceOrientations: UIInterfaceOrientationMask { get }
}

public typealias SnackBarAction = (title: String, action: () -> Void)
public protocol ConnectionViewErrorPresenter {
    var shouldPresentConnectionRetryView: Bool { get }
}
open class BaseViewController<ViewModel: BaseViewModel, View: BaseView>: UIViewController, BaseControllerWithSupportedInterfaces, ConnectionViewErrorPresenter, SnackBarPresenter {

    private var noInternetConnectionView = NoInternetConnectionView()
    public let keyboardWillHideSubject = PublishSubject<Void>()
    public var baseViewModel: ViewModel?
    public var genericView: View { view as? View ?? View() }
    public var disposeBag = DisposeBag()
    public let viewModel: ViewModel
    public let _view: View!

    let dismissKeyboardTagGesture = UITapGestureRecognizer()
    private var isLoadingView = UIView(frame: CGRect.zero)
    let spinner = UIActivityIndicatorView(style: .gray)
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    var viewThatPresentsLoading: UIView {
        self.view
    }
    open var shouldPresentConnectionRetryView: Bool {
        false
    }
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self._view = View()
        noInternetConnectionView = NoInternetConnectionView()
        super.init(nibName: nil, bundle: nil)
        bindUI()
        setNavigationItems()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // override this view to set where your connection error should
    // appear when you received a connection error
    public var viewThatPresentsConnectionError: UIView?

    open override func loadView() {
        view = _view
    }

    open func bindUI() {
        // MARK: - View State Handling Routing
        viewModel.state
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .isLoading:
                    self?.handleLoading(isLoading: true)
                case .error(let error):
                    self?.handleError(error: error)
                case .loaded:
                    self?.handleSuccess()
                case .isLoadingInFullScreen:
                    self?.handleLoadingFullScreen()
                }
            })
            .disposed(by: disposeBag)

        noInternetConnectionView.retryButton.rx.tap.do(onNext: { [weak self] in
            UIView.animate(withDuration: 0.5, animations: {
                self?.noInternetConnectionView.alpha = 0.0
            }, completion: { _ in
                self?.noInternetConnectionViewRetryAction()
                self?.noInternetConnectionView.removeFromSuperview()
            })
        }).subscribe().disposed(by: disposeBag)

        RxKeyboard.instance.visibleHeight
                 .drive(onNext: { [weak self] keyboardVisibleHeight in
                     self?._view.updateSubviewsConstraintsToReflectKeyboardState(keyboardVisibleHeight)
                 })
                 .disposed(by: self.disposeBag)

             RxKeyboard.instance.isHidden.map { $0 }.drive(keyboardWillHideSubject).disposed(by: disposeBag)
    }

    open func setNavigationItems(){
    }
    open func noInternetConnectionViewRetryAction() {
        // Should be overriden
    }
    public func presentSnackBar(withText text: String, withAction snackBarAction: SnackBarAction?) {
        guard self.isVisible else { return }

        MDCSnackbarManager.default.setButtonTitleColor(.white, for: .normal)

        let message = MDCSnackbarMessage()
        message.text = text

        let action = MDCSnackbarMessageAction()
        let actionHandler: MDCSnackbarMessageActionHandler = { () in
            snackBarAction?.action()
        }
        action.handler = actionHandler
        action.title = snackBarAction?.title
        message.action = action

        MDCSnackbarManager.show(message)
    }

    public func presentLoadingView(fullScreen: Bool = false) {
        isLoadingView.alpha = 1.0

        if fullScreen {
            isLoadingView.frame = UIScreen.main.bounds
        } else {
            isLoadingView.frame = viewThatPresentsLoading.bounds
        }

        let activityIndicator = MDCActivityIndicator()
        isLoadingView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        //          activityIndicator.cycleColors = [ColorName.colorSecondary.uiColor]
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        activityIndicator.center = isLoadingView.center
        isLoadingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        if fullScreen {
            navigationController?.topViewController?.tabBarController?.view.addSubview(isLoadingView)
        } else {
            viewThatPresentsLoading.addSubview(isLoadingView)
        }
    }

    public func presentConnectionError(retryButtonAction: (() -> Void)? = nil) {
        noInternetConnectionView = NoInternetConnectionView()
        noInternetConnectionView.frame = _view.bounds
        _view.addSubview(noInternetConnectionView)

        noInternetConnectionView.retryButton.rx.tap.do(onNext: { [weak self] in
            retryButtonAction?()
            self?.noInternetConnectionView.removeFromSuperview()
        }).subscribe().disposed(by: disposeBag)
    }

    private func presentConnectionRetryView() {
        guard let viewThatPresentsConnectionError = viewThatPresentsConnectionError,
            !viewThatPresentsConnectionError.subviews.contains(noInternetConnectionView) else { return }

        noInternetConnectionView.frame = viewThatPresentsConnectionError.bounds
        noInternetConnectionView.alpha = 1.0
        noInternetConnectionView.isHidden = false
        viewThatPresentsConnectionError.addSubview(noInternetConnectionView)
    }

    private func presentConnectionError(_ error: Error) {
        shouldPresentConnectionRetryView ? presentConnectionRetryView() : presentSnackBar(withText: error.localizedDescription, withAction: nil)
    }

    private func removeLoadingFromSuperview() {
        isLoadingView.subviews.forEach { $0.removeFromSuperview() }
        isLoadingView.removeFromSuperview()
    }


    // MARK: - View State Handling
    open func handleLoading(isLoading: Bool) {
        presentLoadingView()
    }

    open func handleLoadingFullScreen() {
        presentLoadingView(fullScreen: true)
    }

    open func handleError(error: Error) {

        func presentUnknownError() {
            presentSnackBar(withText: GenericError.unknown.errorDescription ?? "", withAction: nil)
        }

        removeLoadingFromSuperview()

        if let error = error as? PresentableAppError {
            presentSnackBar(withText: error.errorDescription ?? "", withAction: nil)
            return
        }

        if let networkError = error as? NSError,
            let underlyingError = networkError.userInfo["NSUnderlyingError"] as? NSError {
            switch underlyingError.code {
            case URLError.timedOut.rawValue:
                presentConnectionError(error)
            case URLError.notConnectedToInternet.rawValue:
                presentConnectionError(networkError)
            default:
                presentUnknownError()
            }
            return
        }

        if let errorResponse = error as? BaseAPIErrorResponse,
            let errorMessage = errorResponse.errors.first?.localizedDescription {

            if Int(errorResponse.errors.first?.status ?? "") ?? 500 >= 500 {
                presentUnknownError()
            } else {
                presentSnackBar(withText: errorMessage, withAction: nil)
            }

            return
        }

        presentUnknownError()
    }

    open func handleSuccess() {
        presentViewForNormalStatus()
    }

    public func presentCancelableAlert(withTitle title: String, message: String,
                                       okButtonTitle: String = R.string.base.oK(),
                                       cancelButtonTitle: String = R.string.base.cancel(),
                                       okActionCompletion: (() -> Void)? = nil,
                                       cancelActionCompletion: (() -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            okActionCompletion?()
            alert.dismiss(animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            cancelActionCompletion?()
            alert.dismiss(animated: true, completion: nil)
        }

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }

    public func presentAlert(withTitle title: String, message: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: R.string.base.oK(), style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            completionHandler?()
        }
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    }

    private func presentViewForNormalStatus() {
        UIView.animate(withDuration: 0.3, animations: {
            self.isLoadingView.alpha = 0.0
        }, completion: { _ in
            self.removeLoadingFromSuperview()
        })
    }

    var isVisible: Bool {
        return self.viewIfLoaded?.window != nil
    }
    public func removeDismissKeyboardGesture() {
        self.view.removeGestureRecognizer(dismissKeyboardTagGesture)
    }
}

public protocol SnackBarPresenter: class {
    func presentSnackBar(withText text: String, withAction snackBarAction: SnackBarAction?)
}


