//
//  LanuchViewController.swift
//  AppStart
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import UIKit
//
import RxSwift
//
import Base

public class LaunchScreenViewController: BaseViewController<LaunchScreenViewModel, LaunchScreenView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.launchScreenViewModelComplete.onNext(())
    }
}
