//
//  CurrencyDisplayTableViewCell.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

protocol CurrencyListCell: class {
    var viewModel: CurrencyViewModel? { get set }
}

class CurrencyDisplayTableViewCell: UITableViewCell, UITextFieldDelegate, CurrencyListCell {

    var viewModel: CurrencyViewModel? {
        didSet {
            textLabel?.text = viewModel?.currency.code
            detailTextLabel?.text = viewModel?.currency.name
            moneyField.text = viewModel?.formattedValue
        }
    }

    var onCurrencyValueChanged: ((Double)-> Void)?

    private lazy var moneyField: UILabel = {
        let field = UILabel(frame: .zero)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .right
        field.widthAnchor.constraint(lessThanOrEqualToConstant: 160).isActive = true
        return field
    }()

    private lazy var textAccessoryView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        view.addSubview(moneyField)
        moneyField.snapToEdges(of: view)
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
