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
    let formattedValue: String?

    init(currency: Currency, value: Double){
        self.currency = currency
        self.value = value
        self.formattedValue = Formatter.currency.string(for: value)
    }

}

enum CurrencyListTableSection: Int {
    case principal
    case others

    static let selectedCurrencyIndexPath: IndexPath = IndexPath(row: 0, section: CurrencyListTableSection.principal.rawValue)
    func indexPath(for row: Int)-> IndexPath {
        if case .principal = self { return CurrencyListTableSection.selectedCurrencyIndexPath }
        return IndexPath(row: row, section: CurrencyListTableSection.others.rawValue)
    }
}

enum CurrencyListViewModel {

    case loaded(selected: CurrencyViewModel, list: [CurrencyViewModel])
    case loading
    case error

}

extension CurrencyListViewModel {

    var numberOfSections: Int {
        switch self {
        case .loading:
            return 1
        case .loaded:
            return 2
        case .error:
            return 0
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

    func cellHeight(forIndexPath indexPath: IndexPath, tableView: UITableView)-> CGFloat {
        switch self {
        case .loading:
            return tableView.bounds.height
        case .loaded:
            return 70
        case .error:
            return 0
        }
    }

    func numberOfRows(in section: Int)-> Int {
        switch self {
        case .loading:
            return 1
        case .loaded where section == CurrencyListTableSection.principal.rawValue:
            return 1
        case .loaded(_, let list):
            return list.count
        case .error:
            return 0
        }
    }

    func cellType(forIndexPath indexPath: IndexPath)-> UITableViewCell.Type {
        switch self {
        case .loading:
            return CurrencyDisplayLoadingTableViewCell.self
        case .loaded where indexPath.section == CurrencyListTableSection.principal.rawValue:
            return CurrencyListEditTableViewCell.self
        case .loaded:
            return CurrencyDisplayTableViewCell.self
        case .error:
            return UITableViewCell.self
        }
    }

    func currencyViewModel(for indexPath: IndexPath)-> CurrencyViewModel? {
        guard case let .loaded(selected, list) = self else { return nil }
        switch (indexPath.section, indexPath.row) {
        case (CurrencyListTableSection.principal.rawValue,_):
            return selected
        case (CurrencyListTableSection.others.rawValue, _) where indexPath.row < list.count :
            return list[indexPath.row]
        default:
            return nil
        }
    }
}
