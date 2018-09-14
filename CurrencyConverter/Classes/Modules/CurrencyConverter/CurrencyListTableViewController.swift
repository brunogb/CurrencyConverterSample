//
//  CurrencyListTableViewController.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyListTableViewController: UITableViewController {

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

    private func updateTable(fromOldData: CurrencyListViewModel) {
        tableView.reloadData()
    }
}
