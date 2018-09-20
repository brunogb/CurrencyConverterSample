//
//  CurrencyListTableViewController.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyListTableViewController: UITableViewController {

    var didSelectCurrencyHandler: (CurrencyViewModel)-> Void = { _ in }
    var currentValueChanged: (Double)-> Void = { _ in }

    var viewModel: CurrencyListViewModel = .loading {
        didSet {
            DispatchQueue.main.async {
                self.refreshTableData(comparingOldData: oldValue)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 64
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(type: viewModel.cellType(forIndexPath: indexPath), indexPath: indexPath)
        if let cell = cell as? CurrencyListEditTableViewCell {
            cell.onCurrencyValueChanged = { [unowned self] value in
                self.currentValueChanged(value)
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CurrencyListCell,
            let currencyViewModel = viewModel.currencyViewModel(for: indexPath) {
            cell.viewModel = currencyViewModel
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let validViewModel = viewModel.currencyViewModel(for: indexPath) else { return }
        didSelectCurrencyHandler(validViewModel)
        tableView.scrollToRow(at: CurrencyListTableSection.selectedCurrencyIndexPath,
                              at: .top,
                              animated: true)
        
    }

    private func refreshTableData(comparingOldData oldData: CurrencyListViewModel) {
        guard viewModel.currency != nil && oldData.currency != nil else {
            tableView.reloadData()
            return
        }
        if viewModel.currency != oldData.currency {
            tableView.beginUpdates()
            moveSelectedCurrencyRowUp(from: oldData, to: viewModel)
            tableView.endUpdates()
        }
        updateVisibleCells(of: tableView)
    }

    private func updateVisibleCells(of tableView: UITableView) {
        let cells = tableView.visibleCells
        cells.filter({ $0 is CurrencyListCell })
            .compactMap({ (cell)-> (UITableViewCell, IndexPath)? in
                if let indexPath = tableView.indexPath(for: cell) {
                    return (cell, indexPath)
                }
                return nil
            })
            .compactMap({ (cell, indexPath)-> (CurrencyListCell, CurrencyViewModel)? in
                if let viewModel = self.viewModel.currencyViewModel(for: indexPath),
                    let cell = cell as? CurrencyListCell {
                    return (cell, viewModel)
                }
                return nil
            })
            .forEach( { (pair) in
                let (cell, viewModel) = pair
                cell.viewModel = viewModel
            })
    }

    private func moveSelectedCurrencyRowUp(from oldModel: CurrencyListViewModel, to newModel: CurrencyListViewModel) {
        guard let newSelectedCurrency = newModel.currency,
            let oldSelectedCurrency = oldModel.currency,
            let oldCellIndex = oldModel.index(for: newSelectedCurrency),
            let newIndexForOldSelected = newModel.index(for: oldSelectedCurrency) else { return }
        let moveFromIndexPath = CurrencyListTableSection.others.indexPath(for: oldCellIndex)
        let moveToIndexPath = CurrencyListTableSection.selectedCurrencyIndexPath
        let insertIndexPath = CurrencyListTableSection.others.indexPath(for: newIndexForOldSelected)
        tableView.deleteRows(at: [CurrencyListTableSection.selectedCurrencyIndexPath], with: .automatic)
        tableView.moveRow(at: moveFromIndexPath, to: moveToIndexPath)
        tableView.insertRows(at: [insertIndexPath], with: .automatic)
    }
}
