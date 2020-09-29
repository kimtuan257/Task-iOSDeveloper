//
//  DiscoverCoordinator.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

class DiscoverCoordinator: NSObject {

    let navVC: UINavigationController

    init(navVC: UINavigationController) {
        self.navVC = navVC
    }

    func start() {
        let discoverViewModel = DiscoverViewModel()
        let discoverVC = DiscoverVC(viewModel: discoverViewModel)
        navVC.pushViewController(discoverVC, animated: true)
    }
}
