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
                self.updateTable(comparingOldData: oldValue)
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
        let cell = tableView.dequeue(type: viewModel.cellType(), indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CurrencyDisplayTableViewCell,
            let currencyViewModel = viewModel.currencyViewModel(for: indexPath) else { return }
        cell.viewModel = currencyViewModel
        if currencyViewModel.editable {
            cell.onCurrencyValueChanged = { [unowned self] value in
                self.currentValueChanged(value)
            }
        }
        else {
            cell.onCurrencyValueChanged = nil
        }

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let validViewModel = viewModel.currencyViewModel(for: indexPath) else { return }
        didSelectCurrencyHandler(validViewModel)
        tableView.scrollToRow(at: CurrencyListViewModel.CurrencyListSection.selectedCurrencyIndexPath, at: .top, animated: true)
        
    }

    private func updateTable(comparingOldData oldData: CurrencyListViewModel) {
        guard viewModel.currency != nil && oldData.currency != nil else {
            tableView.reloadData()
            return
        }
        tableView.beginUpdates()
        if !viewModel.sameSelectedCurrency(as: oldData) {
            moveSelectedCurrencyRowUp(from: oldData, to: viewModel)
        }
        tableView.endUpdates()
        for cell in tableView.visibleCells {
            guard let cell = cell as? CurrencyDisplayTableViewCell,
                let indexPath = tableView.indexPath(for: cell) else { continue }
            tableView(tableView, willDisplay: cell, forRowAt: indexPath)

        }
    }

    private func moveSelectedCurrencyRowUp(from oldModel: CurrencyListViewModel, to newModel: CurrencyListViewModel) {
        guard let newSelectedCurrency = newModel.currency,
            let oldSelectedCurrency = oldModel.currency,
            let oldCellIndex = oldModel.index(for: newSelectedCurrency),
            let newIndexForOldSelected = newModel.index(for: oldSelectedCurrency) else { return }
        let moveFromIndexPath = CurrencyListViewModel.CurrencyListSection.others.indexPath(for: oldCellIndex)
        let moveToIndexPath = CurrencyListViewModel.CurrencyListSection.selectedCurrencyIndexPath
        let insertIndexPath = CurrencyListViewModel.CurrencyListSection.others.indexPath(for: newIndexForOldSelected)
        tableView.deleteRows(at: [CurrencyListViewModel.CurrencyListSection.selectedCurrencyIndexPath], with: .automatic)
        tableView.moveRow(at: moveFromIndexPath, to: moveToIndexPath)
        tableView.insertRows(at: [insertIndexPath], with: .automatic)
    }
}
