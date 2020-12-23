//
//  ViewModelType.swift
//  Base
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModelType {
    var disposeBag: DisposeBag { get set }
    var state: PublishRelay<State> { get set }
    var loadTrigger: PublishRelay<()> { get set }
    var didTriggerDeveloperToolsObservable: PublishSubject<Void> { get set }
    var didDismissedModal: PublishSubject<Void> { get set }
}
