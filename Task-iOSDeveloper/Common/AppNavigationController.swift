//
//  AppNavigationController.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

import UIKit

class AppNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIGraphicsImageRenderer(size: .init(width: 1, height: 1)).image { ctx in
            ctx.cgContext.setFillColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor)
            ctx.fill(.init(x: 0, y: 0, width: 1, height: 1))
        }

        navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.darkGray,
                                              .font: UIFont.systemFont(ofSize: 16, weight: .medium)]

        interactivePopGestureRecognizer?.delegate = self
        navigationBar.prefersLargeTitles = true

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemYellow
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .systemYellow
            UINavigationBar.appearance().isTranslucent = false
        }
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    @objc
    func handleBack(_ sender: Any) {
        self.popViewController(animated: true)
    }
}

extension AppNavigationController: ContentScrollToTopable {
    func scrollToTop() {
        if viewControllers.count == 1, let rootVC = topViewController as? ContentScrollToTopable {
            rootVC.scrollToTop()
        }
    }
}
