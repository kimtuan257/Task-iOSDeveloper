//
//  PrizesVC.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

class PrizesVC: UIViewController {

    private var viewModel: PrizesViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    init(viewModel: PrizesViewModelType) {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
