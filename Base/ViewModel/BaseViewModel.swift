//
//  BaseViewModel.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation

import RxSwift
import RxCocoa

public enum State {
    case isLoading
    // TODO: Refactor and remove this. It should be a option in isLoading state
    case isLoadingInFullScreen
    case error(Error)
    case loaded

    var isLoaded: Bool {
        switch self {
        case .loaded:
            return true
        default:
            return false
        }
    }
}

open class BaseViewModel: ViewModelType {

    public var disposeBag = DisposeBag()
    public var state: PublishRelay<State>
    public var loadTrigger: PublishRelay<()>
    public var didTriggerDeveloperToolsObservable = PublishSubject<Void>()
    public var didDismissedModal = PublishSubject<Void>()

    required public init() {
        state = PublishRelay<State>()
        loadTrigger = PublishRelay<()>()

        Observable.combineLatest(state, loadTrigger)
            .filter { tuple in !tuple.0.isLoaded }
            .flatMap { _ in return Observable<Void>.just(()) }
            .subscribe(onNext: { [weak self] _ in
                self?.load()
            }).disposed(by: disposeBag)

        bindObservables()
    }

    func load() {
        fatalError("Subclasses must override AND NOT CALL super")
    }

     open func bindObservables() {}

       public func subscribePropagatingErrors<T>(to single: Single<T>,
                                     onSuccess: ((T) -> Void)? = nil,
                                     onError: ((Error) -> Void)? = nil) -> Disposable {

           return single.subscribe(onSuccess: { element in
               onSuccess?(element)
           }, onError: { [weak self] (error) in
               onError?(error)
               self?.state.accept(.error(error))
           })
       }
}


