//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    let service: CurrencyConverterService

    var viewModel: CurrencyConverterViewModel? {
        didSet {
            updateTable(with: viewModel)
        }
    }

    init(service: CurrencyConverterService = CurrencyConverterService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Interface builder not allowed") }
    
    private lazy var tableViewController: CurrencyListTableViewController = {
        let viewController = CurrencyListTableViewController()
        return viewController
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        set(contentController: tableViewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTable(with: viewModel)
        service.requestUpdates(for: "EUR") { [unowned self] (result) in
            switch result {
            case .error(let error):
                self.viewModel = nil
                print("Error: \(error)")
                break
            case .success(let converter):
                self.viewModel = CurrencyConverterViewModel(converter: converter,
                                                       selectedCurrency: self.viewModel?.selectedCurrency,
                                                       value: self.viewModel?.value)
            }
        }
        tableViewController.didSelectCurrencyHandler = { currencyModel in
            guard let viewModel = self.viewModel else { return }
            let newConverter = viewModel.converter.converterChangingCurrent(currency: currencyModel.currency)
            self.viewModel = CurrencyConverterViewModel(converter: newConverter,
                                                        selectedCurrency: currencyModel.currency,
                                                        value: currencyModel.value)
        }
    }

    private func updateTable(with model: CurrencyConverterViewModel?) {
        tableViewController.viewModel = model?.listViewModel() ?? .loading
    }

}
