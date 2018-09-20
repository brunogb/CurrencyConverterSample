//
//  CurrencyDisplayLoadingTableViewCell.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyDisplayLoadingTableViewCell: UITableViewCell {

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.color = .darkGray
        view.hidesWhenStopped = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(loadingIndicator)
        loadingIndicator.centerIn(self)

    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Interface builder not allowed") }
    
}
