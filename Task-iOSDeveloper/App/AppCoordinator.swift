//
//  AppCoordinator.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

class AppCoordinator: NSObject {

    private lazy var appTabbarController: AppTabbarController = {
        let tabbar = AppTabbarController()
        return tabbar
    }()
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = appTabbarController
    }
}
