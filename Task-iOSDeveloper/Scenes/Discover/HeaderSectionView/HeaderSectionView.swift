//
//  MainWhatUpCell.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//


import UIKit

protocol HeaderSectionViewDelegate: NSObjectProtocol {
    func headerSectionView(sectionView: HeaderSectionView, didTapMoreAt section: Int)
}

class HeaderSectionView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    weak var delegate: HeaderSectionViewDelegate?
    private var section = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        contentLabel.isHidden = true
        titleLabel.text = "What's up?"
        backgroundColor = .clear
    }

    @IBAction func didTapHeader(_ sender: Any) {
        
    }
}
