//
//  AppTabbarController.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

protocol AppTabbarControllerDismissDelegate: class {
    func appTabbarController(_ tabbarController: AppTabbarController, didDismissVC viewcontroller: UIViewController?)
}

class AppTabbarController: UITabBarController {

    weak var appTabbarControllerDismissDelegate: AppTabbarControllerDismissDelegate?
    var discoverCoordinator: DiscoverCoordinator?
    var nearMeCoordinator: NearMeCoordinator?
    var prizesCoordinator: PrizesCoordinator?

    deinit {
        print("Deinit \(self.classForCoder)")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorStyles()
        showContent()
    }

    func showContent() {
        let discoverNV = AppNavigationController()
        discoverNV.tabBarItem = UITabBarItem(title: "Discover",
                                             image: nil,
                                             selectedImage: nil)
        let nearMeNV = AppNavigationController()
        nearMeNV.tabBarItem = UITabBarItem(title: "Near me",
                                           image: nil,
                                           selectedImage: nil)
        let prizesNV = AppNavigationController()
        prizesNV.tabBarItem = UITabBarItem(title: "Prizes",
                                           image: nil,
                                           selectedImage: nil)


        let arrayViewControllers: [AppNavigationController] = [discoverNV,
                                                               nearMeNV,
                                                               prizesNV]

        let discoverCoordinator = DiscoverCoordinator(navVC: discoverNV)
        discoverCoordinator.start()
        self.discoverCoordinator = discoverCoordinator

        let nearMeCoordinator = NearMeCoordinator(navVC: nearMeNV)
        nearMeCoordinator.start()
        self.nearMeCoordinator = nearMeCoordinator

        let prizesCoordinator = PrizesCoordinator(navVC: prizesNV)
        prizesCoordinator.start()
        self.prizesCoordinator = prizesCoordinator

        setViewControllers(arrayViewControllers, animated: true)
    }

    func setupColorStyles() {
        let barItem = UITabBarItem.appearance(whenContainedInInstancesOf: [type(of: self)])
        let font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.darkGray,
            .paragraphStyle: paragraphStyle
        ]
        let selectedArttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.systemYellow,
            .paragraphStyle: paragraphStyle
        ]

        let shadowSize = CGSize(width: view.frame.size.width, height: 0.5)
        let shadowImage = UIGraphicsImageRenderer(size: shadowSize).image(actions: { cxt in
            cxt.cgContext.setFillColor(UIColor.lightGray.cgColor)
            cxt.cgContext.fill(CGRect.init(origin: .zero, size: shadowSize))
        })
        let titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        if #available(iOS 13, *) {
            let appearance = self.tabBar.standardAppearance.copy()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = shadowImage
            appearance.backgroundColor = .white
            appearance.selectionIndicatorTintColor = .darkGray

            appearance.stackedLayoutAppearance.normal.iconColor = .darkGray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = titlePositionAdjustment
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedArttributes
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = titlePositionAdjustment

            tabBar.standardAppearance = appearance
        } else {
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = shadowImage
            barItem.setTitleTextAttributes(normalAttributes, for: .normal)
            barItem.setTitleTextAttributes(selectedArttributes, for: .selected)
            barItem.titlePositionAdjustment = titlePositionAdjustment
        }
        tabBar.barTintColor = #colorLiteral(red: 0.6235294118, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        tabBar.isTranslucent = false
        view.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = self.tabBar.items?.firstIndex(of: item) else { return }
        if index == self.selectedIndex, let scrollToTopable = self.viewControllers?[index] as? ContentScrollToTopable {
            scrollToTopable.scrollToTop()
        }
    }

    func dismissModalScreen(_ completionHandler: @escaping () -> Void) {
        if let presentedViewController = presentedViewController {
            dismiss(animated: true, completion: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.appTabbarControllerDismissDelegate?.appTabbarController(strongSelf, didDismissVC: presentedViewController)
                completionHandler()
            })
        } else {
            appTabbarControllerDismissDelegate?.appTabbarController(self, didDismissVC: nil)
            DispatchQueue.main.async(execute: completionHandler)
        }
    }

}

public protocol ContentScrollToTopable {
    func scrollToTop()
}

