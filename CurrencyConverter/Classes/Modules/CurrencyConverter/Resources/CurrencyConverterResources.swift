//
//  CurrencyConverterListResource.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyConverterResources {

    static func listResource(for currency: String)-> JSONResource<CurrencyConverterListResponse> {
        return JSONResource(path: "latest",
                            parameters: ["base": currency],
                            decoder: JSONDecoder(dateFormat: "yyyy-MM-dd"))
    }

}
