//
//  CurrencyDisplayTableViewCell.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyDisplayTableViewCell: UITableViewCell {

    var viewModel: CurrencyViewModel? {
        didSet {
            textLabel?.text = viewModel?.currency.code
            detailTextLabel?.text = viewModel?.currency.name
            moneyTextField.text = "\(viewModel?.value ?? 0)"
            moneyTextField.isEnabled = viewModel?.editable ?? false
        }
    }

    private lazy var moneyTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.widthAnchor.constraint(lessThanOrEqualToConstant: 160).isActive = true
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

}
