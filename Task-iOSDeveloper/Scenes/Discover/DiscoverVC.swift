//
//  DiscoverVC.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit
import SVProgressHUD

class DiscoverVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: DiscoverViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "Discover"
        setUpUI()
        SVProgressHUD.show()
        viewModel?.getVenueDashboard()
        viewModel?.dataDelegate = self
    }
    
    init(viewModel: DiscoverViewModelType) {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        collectionView.register(UINib(nibName: "MainWhatUpCell", bundle: nil), forCellWithReuseIdentifier: "MainWhatUpCell")
        collectionView.register(UINib(nibName: "WhatUpCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WhatUpCollectionViewCell")
        collectionView.register(UINib(nibName: "HeaderSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSectionView")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9490196078, alpha: 1)
    }
}

extension DiscoverVC: DiscoverViewModelDataDelegate {
    func discoverViewModelDidLoadWhatUpList(viewModel: DiscoverViewModelType) {
        SVProgressHUD.dismiss()
        collectionView.reloadData()
    }
}

extension DiscoverVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel?.sections[section] {
        case .listWhatUp:
            return 1
        default:
            if let _ = viewModel?.listTrending.first {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel?.sections[indexPath.section] {
        case .listWhatUp(let state):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainWhatUpCell", for: indexPath) as? MainWhatUpCell else {
                fatalError("Imposiple case!!!")
            }
            switch state {
            case .loading:
                break
            case .loaded(let listTrending):
                cell.setDataForCell(listTrending: listTrending)
            default:
                break
            }
            return cell
        case .whatUp:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhatUpCollectionViewCell", for: indexPath) as? WhatUpCollectionViewCell,
                  let trending = viewModel?.listTrending.first else {
                fatalError("Imposiple case!!!")
            }
            cell.setDataForCell(trending: trending)
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch viewModel?.sections[indexPath.section] {
            case .listWhatUp:
                guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSectionView", for: indexPath) as? HeaderSectionView else { fatalError("Imposiple case!!!") }
                return reusableView
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch viewModel?.sections[section] {
        case .listWhatUp(let state):
            switch state {
            case .loaded:
                return CGSize(width: collectionView.bounds.width, height: 70)
            default:
                return .zero
            }
        default:
            return .zero
        }
    }
}

extension DiscoverVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel?.sections[indexPath.section] {
        case .listWhatUp, .whatUp:
            return CGSize(width: collectionView.bounds.width - 24, height: 350)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch viewModel?.sections[section] {
        case .listWhatUp:
            return UIEdgeInsets(top: 0, left: 24, bottom: 12, right: 24)
        default:
            return UIEdgeInsets(top: 12, left: 24, bottom: 0, right: 24)
        }
    }
}
