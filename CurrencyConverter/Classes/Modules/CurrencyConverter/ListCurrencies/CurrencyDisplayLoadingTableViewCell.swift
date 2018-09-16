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
        view.color = .darkGray
        view.startAnimating()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(loadingIndicator)
        loadingIndicator.centerIn(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("Interface builder not allowed") }
    
}
