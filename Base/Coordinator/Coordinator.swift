//
//  Coordinator.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import RxSwift

/// Use this base coordinator to control navigation between scenes. __Your coordinator should not be linked in anywhere.__
/// what you have to have to do is to subscribe to your viewModel observable that is used for navigation and handle it
/// here inside the coordinator. You __SHOULD NOT__ directly handle the `childCoordinators` array or call `store()` or `free()` methods
/// what you have to do is simply return an observable on your `start()` method combining every observable that can free / end your coordinator's flow
open class Coordinator<ResultType> {

    typealias CoordinationResult = ResultType

    public let disposeBag: DisposeBag

    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    public init() {
        disposeBag = DisposeBag()
    }

    /// Stores coordinator to the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Child coordinator to store.
    private func store<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
        print("COORDINATORS IN MEMORY: \(childCoordinators)")
    }

    /// Release coordinator from the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Coordinator to release.
    private func free<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
        print("COORDINATORS IN MEMORY: \(childCoordinators)")
    }

    /// 1. Stores coordinator in a dictionary of child coordinators.
    /// 2. Calls method `start()` on that coordinator.
    /// 3. On the `onNext:` of returning observable of method `start()` removes coordinator from the dictionary.
    ///
    /// - Parameter coordinator: Coordinator to start.
    /// - Returns: Result of `start()` method.
    public func coordinate<T>(to coordinator: Coordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
    }

    /// Starts job of the coordinator.
    ///
    /// - Returns: Result of coordinator job.
    open func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
    /// Starts job of the coordinator.
    ///
    /// - Returns: Result of coordinator job.
    open func start(_ withDeepLink: String?) -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}

