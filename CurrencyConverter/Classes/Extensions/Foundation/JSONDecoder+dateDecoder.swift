//
//  JSONDecoder+dateDecoder.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

extension JSONDecoder {

    convenience init(dateFormat: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        self.init(dateFormatter: formatter)
    }

    convenience init(dateFormatter: DateFormatter) {
        self.init()
        dateDecodingStrategy = .formatted(dateFormatter)
    }

}
