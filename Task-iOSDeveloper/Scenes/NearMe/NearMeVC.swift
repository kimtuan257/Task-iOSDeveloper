//
//  NearMeVC.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

class NearMeVC: UIViewController {

    private var viewModel: NearMeViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    init(viewModel: NearMeViewModelType) {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
