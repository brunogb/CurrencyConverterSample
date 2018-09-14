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
    let value: Double
    let editable: Bool

}

enum CurrencyListViewModel {

    case loaded(selected: CurrencyViewModel, list: [CurrencyViewModel])
    case loading

    enum CurrencyListSection: Int {
        case principal
        case others

        static let selectedCurrencyIndexPath: IndexPath = IndexPath(row: 0, section: CurrencyListSection.principal.rawValue)
        func indexPath(for row: Int)-> IndexPath {
            if case .principal = self { return CurrencyListSection.selectedCurrencyIndexPath }
            return IndexPath(row: row, section: CurrencyListSection.others.rawValue)
        }
    }

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

    var currency: Currency? {
        if case let .loaded(selected, _) = self {
            return selected.currency
        }
        return nil
    }

    var otherCurrencies: [CurrencyViewModel] {
        if case let .loaded(_, list) = self {
            return list
        }
        return []
    }

    func index(for currency: Currency)-> Int? {
        return otherCurrencies.firstIndex(where: { (model) -> Bool in
            return model.currency == currency
        })
    }

    func numberOfRows(in section: Int)-> Int {
        switch self {
        case .loading:
            return 0
        case .loaded where section == CurrencyListSection.principal.rawValue:
            return 1
        case .loaded(_, let list):
            return list.count
        }
    }

    func sameSelectedCurrency(as otherModel: CurrencyListViewModel)-> Bool {
        return currency == otherModel.currency
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
        case (CurrencyListSection.principal.rawValue,_):
            return selected
        case (CurrencyListSection.others.rawValue, _) where indexPath.row < list.count :
            return list[indexPath.row]
        default:
            return nil
        }
    }
}
