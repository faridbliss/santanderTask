//
//  AppDelegate.swift
//  SantanderTask
//
//  Created by Farid Ullah on 16/12/2020.
//

import UIKit
import Resources
import RxSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator:GlobalCoordinator?
    let disposeBag = DisposeBag()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            R.registerFonts()
            try R.validate()
        } catch {
            print(error)
        }
        coordinator = GlobalCoordinator()
        coordinator?.start().subscribe().disposed(by: disposeBag)
        return true
    }

}

