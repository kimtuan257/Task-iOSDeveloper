//
//  WhatUpCollectionViewCell.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

import UIKit
import FSPagerView
import SDWebImage

class WhatUpCollectionViewCell: FSPagerViewCell {

    @IBOutlet weak var whatupImageView: UIImageView!
    @IBOutlet weak var nameWhatUpLabel: UILabel!
    @IBOutlet weak var descriptionWhatUpLabel: UILabel!
    @IBOutlet weak var contentCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        contentCellView.clipsToBounds = true
        contentCellView.layer.cornerRadius = 10.0
        contentCellView.backgroundColor = .white

        let sdLoadImageIndicator = SDWebImageActivityIndicator()
        sdLoadImageIndicator.indicatorView.color = .systemYellow
        whatupImageView.sd_imageIndicator = sdLoadImageIndicator
        whatupImageView.sd_imageTransition = .fade

        contentView.layer.shadowColor = UIColor.clear.cgColor
        whatupImageView.layer.cornerRadius = 10.0
        whatupImageView.clipsToBounds = true
    }

    func setDataForCell(trending: Trending) {
        nameWhatUpLabel.text = trending.name
        let nsMutableAttributeString = NSMutableAttributedString(string: trending.type, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .semibold),
                                                                                                     .foregroundColor: UIColor.systemYellow])
        let attributeString = NSAttributedString(string: " • " + trending.city, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .semibold),
                                                                                     .foregroundColor: UIColor.lightGray])
        nsMutableAttributeString.append(attributeString)
        descriptionWhatUpLabel.attributedText = nsMutableAttributeString
        if let iconURL = URL(string: trending.pictureURL) {
            whatupImageView.sd_setImage(with: iconURL) { [weak self] (_, error, _, _) in
                guard let strongSelf = self else { return }
                if error != nil {
                    strongSelf.whatupImageView = nil
                }
            }
        }
    }

}
