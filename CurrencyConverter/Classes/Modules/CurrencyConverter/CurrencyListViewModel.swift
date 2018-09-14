//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

struct CurrencyViewModel {

    let currency: Currency
    let value: Float

}

enum CurrencyListViewModel {

    case loaded(selected: CurrencyViewModel, list: [CurrencyViewModel])
    case loading

}

extension CurrencyListViewModel {

    var numberOfSections: Int {
        switch self {
        case .loading:
            return 1
        case .loaded:
            return 2
        }
    }

    func numberOfRows(in section: Int)-> Int {
        switch self {
        case .loading:
            return 0
        case .loaded where section == 0:
            return 1
        case .loaded(_, let list):
            return list.count
        }
    }

    func cellType()-> UITableViewCell.Type {
        switch self {
        case .loading:
            return UITableViewCell.self
        case .loaded:
            return CurrencyDisplayTableViewCell.self
        }
    }

    func currencyViewModel(for indexPath: IndexPath)-> CurrencyViewModel? {
        guard case let .loaded(selected, list) = self else { return nil }
        switch (indexPath.section, indexPath.row) {
        case (0,_):
            return selected
        case (1, _) where indexPath.row < list.count :
            return list[indexPath.row]
        default:
            return nil
        }
    }
}
