//
//  DiscoverViewModel.swift
//  Task-iOSDeveloper
//
//  Created by Tuan Le on 9/28/20.
//

import UIKit

protocol DiscoverViewModelDataDelegate: NSObjectProtocol {
    func discoverViewModelDidLoadWhatUpList(viewModel: DiscoverViewModelType)
}

protocol DiscoverViewModelType {
    var sections: [DiscoverSection] { get }
    var dataDelegate: DiscoverViewModelDataDelegate? { set get }
    var listTrending: [Trending] { get }
    func getVenueDashboard()
}

enum ModelState<T> {
    case initial
    case loading
    case loaded(T)
    case error(Error)
}

extension ModelState: Equatable {
    static func == (lhs: ModelState<T>, rhs: ModelState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial): return true
        case (.loading, .loading): return true
        case (.loaded, .loaded): return true
        case (.error, .error): return true
        default: return false
        }
    }
}

enum DiscoverSection {
    case whatUp
    case listWhatUp(ModelState<[Trending]>)
}

class DiscoverViewModel: DiscoverViewModelType {

    weak var dataDelegate: DiscoverViewModelDataDelegate?
    var sections: [DiscoverSection] = [
        .whatUp,
        .listWhatUp(.loading)
    ]

    var listTrending = [Trending]()

    var listWhatUpState: ModelState<[Trending]> {
        get {
            var result: ModelState<[Trending]>!
            for section in sections {
                if case .listWhatUp(let state) = section {
                    result = state
                    break
                }
            }
            return result
        }
        set {
            if let index = sections.firstIndex(where: {
                if case .listWhatUp = $0 {
                    return true
                } else {
                    return false
                }
            }) {
                sections[index] = .listWhatUp(newValue)
            }
        }
    }

    init() {

    }

    func getVenueDashboard() {
        listWhatUpState = .loading
        API.getVenueDashBoard { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                strongSelf.listWhatUpState = .loaded([])
                strongSelf.listTrending = []
                strongSelf.dataDelegate?.discoverViewModelDidLoadWhatUpList(viewModel: strongSelf)
            case .success(let dashboaed):
                strongSelf.listWhatUpState = .loaded(dashboaed.trending)
                strongSelf.listTrending = dashboaed.trending
                strongSelf.dataDelegate?.discoverViewModelDidLoadWhatUpList(viewModel: strongSelf)
            }
        }
    }
}
