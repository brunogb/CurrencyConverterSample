//
//  CurrencyConverterService.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class CurrencyConverterService {

    let requester: Requester

    var currentToken: RequestToken?

    init(requester: Requester = .default) {
        self.requester = requester
    }

    func requestUpdates(for currency: String, onUpdate: @escaping(Result<CurrencyConverter>) -> Void) {
        let resource = CurrencyConverterResources.listResource(for: currency)
        currentToken = requester.request(resource: resource) { (result) in
            let converterResult = result.map(closure: { (response) -> CurrencyConverter in
                let currency = Currency(code: response.base)
                return CurrencyConverter(base: currency, fxTable: response.rates)
            })
            onUpdate(converterResult)
            DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
                self.requestUpdates(for: currency, onUpdate: onUpdate)
            })
        }
    }

}
