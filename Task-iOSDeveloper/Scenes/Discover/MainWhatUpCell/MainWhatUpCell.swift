//
//  MainWhatUpCell.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/29/20.
//

import UIKit
import FSPagerView

class MainWhatUpCell: UICollectionViewCell {

    @IBOutlet weak var whatUpPagerView: FSPagerView!
    private var listTrending = [Trending]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        whatUpPagerView.register(UINib(nibName: "WhatUpCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WhatUpCollectionViewCell")
        whatUpPagerView.interitemSpacing = UIScreen.main.bounds.width * 0.064
        let width = UIScreen.main.bounds.width * 0.7
        whatUpPagerView.itemSize = CGSize(width: width, height: width / 0.75)
        whatUpPagerView.delegate = self
        whatUpPagerView.dataSource = self

        whatUpPagerView.backgroundColor = .clear
    }

    func setDataForCell(listTrending: [Trending]) {
        self.listTrending = listTrending
        whatUpPagerView.reloadData()
    }

}

extension MainWhatUpCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listTrending.count
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "WhatUpCollectionViewCell", at: index) as? WhatUpCollectionViewCell else {
            fatalError("Impossible case!!!")
        }
        cell.setDataForCell(trending: listTrending[index])
        return cell
    }
}

extension MainWhatUpCell: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.scrollToItem(at: index, animated: true)
    }
}
