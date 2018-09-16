//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

   private let service: CurrencyConverterService

    private lazy var tableViewController: CurrencyListTableViewController = {
        let viewController = CurrencyListTableViewController()
        return viewController
    }()

    var viewModel: CurrencyConverterViewModel?

    init(service: CurrencyConverterService = URLCurrencyConverterService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Interface builder not allowed") }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        set(contentController: tableViewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.viewModel = .loading
        service.requestUpdates(for: "EUR") { [unowned self] (result) in
            self.handleService(result: result)
        }
        tableViewController.didSelectCurrencyHandler = { [unowned self] currencyModel in
            self.selectCurrency(from: currencyModel)
        }
        tableViewController.currentValueChanged = { [unowned self] value in
            self.viewModel?.value = value
        }
    }

    private func handleService(result: Result<CurrencyConverter>) {
        switch result {
        case .error(let error):
            self.viewModel = nil
            handleErrorFromService(error)
            break
        case .success(let converter):
            updateConverter(converter)
        }
    }

    private func updateConverter(_ converter: CurrencyConverter) {
        let newModel = CurrencyConverterViewModel(converter: converter,
                                                  selectedCurrency: self.viewModel?.selectedCurrency,
                                                  value: self.viewModel?.value)
        self.viewModel = newModel
        tableViewController.viewModel = newModel.listViewModel()
    }

    private func handleErrorFromService(_ error: Error) {
        print("Error: \(error)")
        if case .error = self.tableViewController.viewModel { return }
        self.tableViewController.viewModel = .error
        let errorController = UIAlertController(title: "Error while updating currencies",
                                                message: "There was an error while we were updating currencies.",
                                                preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Close",
                                                style: .default,
                                                handler: nil))
        self.present(errorController,
                     animated: true,
                     completion: nil)
    }

    private func selectCurrency(from currencyModel: CurrencyViewModel) {
        guard let viewModel = self.viewModel else { return }
        let newConverter = viewModel.converter.converterChangingCurrent(currency: currencyModel.currency)
        self.viewModel = CurrencyConverterViewModel(converter: newConverter,
                                                    selectedCurrency: currencyModel.currency,
                                                    value: currencyModel.value)
    }

}
