//
//  CurrencyConverterListResponse.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

struct CurrencyConverterListResponse: Decodable {

    let base: String
    let date: Date
    let rates: [String: Float]

}
