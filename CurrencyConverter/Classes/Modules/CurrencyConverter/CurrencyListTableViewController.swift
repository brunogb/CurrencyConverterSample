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

    var viewModel: CurrencyListViewModel = .loading {
        didSet {
            DispatchQueue.main.async {
                self.updateTable(fromOldData: oldValue)
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
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let validViewModel = viewModel.currencyViewModel(for: indexPath) else { return }
        didSelectCurrencyHandler(validViewModel)
    }

    private func updateTable(fromOldData: CurrencyListViewModel) {
        tableView.reloadData()
    }
}
