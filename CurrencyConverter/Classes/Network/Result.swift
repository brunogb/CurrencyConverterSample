//
//  Result.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

enum Result<T> {
    case success(T)
    case error(Error)
}

extension Result {

    func map<N>(closure: (T) throws -> N)-> Result<N> {
        switch self {
        case .error(let error):
            return .error(error)
        case .success(let value):
            do {
                let newValue = try closure(value)
                return .success(newValue)
            }
            catch (let convertError) {
                return .error(convertError)
            }

        }
    }

}
