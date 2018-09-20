//
//  CurrencyListEditTableViewCell.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 19/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyListEditTableViewCell: UITableViewCell, UITextFieldDelegate, CurrencyListCell {

    var viewModel: CurrencyViewModel? {
        didSet {
            textLabel?.text = viewModel?.currency.code
            detailTextLabel?.text = viewModel?.currency.name
            moneyTextField.doubleValue = viewModel?.value ?? 0
        }
    }

    var onCurrencyValueChanged: ((Double)-> Void)?

    private lazy var moneyTextField: CurrencyTextField = {
        let textField = CurrencyTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.widthAnchor.constraint(lessThanOrEqualToConstant: 160).isActive = true
        textField.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        return textField
    }()

    private lazy var textAccessoryView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        view.addSubview(moneyTextField)
        moneyTextField.snapToEdges(of: view)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        accessoryView = textAccessoryView
    }

    required init?(coder aDecoder: NSCoder) { fatalError("Interface builder not allowed") }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    @objc private func handleEditingChanged() {
        onCurrencyValueChanged?(moneyTextField.doubleValue)
    }
    
}
