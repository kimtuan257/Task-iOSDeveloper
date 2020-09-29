//
//  PrizesCoordinator.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

class PrizesCoordinator: NSObject {
    let navVC: UINavigationController

    init(navVC: UINavigationController) {
        self.navVC = navVC
    }

    func start() {
        let prizesViewModel = PrizesViewModel()
        let prizeVC = PrizesVC(viewModel: prizesViewModel)
        navVC.pushViewController(prizeVC, animated: true)
    }
}
