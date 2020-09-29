//
//  NearMeCoordinator.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

class NearMeCoordinator: NSObject {
    let navVC: UINavigationController

    init(navVC: UINavigationController) {
        self.navVC = navVC
    }

    func start() {
        let nearMeViewModel = NearMeViewModel()
        let nearMeVC = NearMeVC(viewModel: nearMeViewModel)
        navVC.pushViewController(nearMeVC, animated: true)
    }
}
