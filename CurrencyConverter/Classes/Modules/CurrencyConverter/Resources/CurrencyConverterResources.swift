//
//  CurrencyConverterListResource.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import Foundation

struct CurrencyConverterListResponse: Decodable {

    let base: String
    let date: Date
    let rates: [String: Double]

}

class CurrencyConverterResources {

    static func listResource(for currency: String)-> JSONResource<CurrencyConverterListResponse> {
        return JSONResource(path: "latest",
                            parameters: ["base": currency],
                            decoder: JSONDecoder(dateFormat: "yyyy-MM-dd"))
    }

}
