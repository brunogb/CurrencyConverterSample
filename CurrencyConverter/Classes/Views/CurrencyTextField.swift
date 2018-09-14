//
//  CurrencyTextField.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {
    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digits.decimal /
            Decimal(pow(10, Double(Formatter.currency.maximumFractionDigits)))
    }
    var doubleValue: Double {
        get {
            return decimal.number.doubleValue
        }
        set {
            text = String(format:"%.2f", newValue)
            editingChanged()
        }
    }
    var integerValue: Int { return decimal.number.intValue   }
    let maximum: Decimal = 999_999_999.99
    private var lastValue: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        editingChanged()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Interface builder not allowed") }
    
    override func deleteBackward() {
        text = string.digits.dropLast().string
        sendActions(for: .editingChanged)
    }

    @objc func editingChanged(_ textField: UITextField? = nil) {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = Formatter.currency.string(for: decimal)
        lastValue = text
    }
}
