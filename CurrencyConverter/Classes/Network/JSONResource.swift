//
//  JSONResource.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]

struct JSONResource<Result: Decodable> {

    enum RequestError: Error {
        case urlMalformed(base: URL, path: String, params: JSONDictionary)
    }

    var path: String
    var parameters: JSONDictionary
    var decoder: JSONDecoder

    init(path: String, parameters: JSONDictionary, decoder: JSONDecoder? = nil) {
        self.path = path
        self.parameters = parameters
        self.decoder = decoder ?? JSONDecoder()
    }

    var queryItems: [URLQueryItem] {
        return parameters.compactMap({ (arg) -> URLQueryItem in
            let (key, value) = arg
            return URLQueryItem(name: key, value: String(describing: value))
        })
    }

    func urlRequest(base: URL) throws -> URLRequest {
        var urlComponents = URLComponents(url: base.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        guard let validURL = urlComponents?.url else {
            throw RequestError.urlMalformed(base: base, path: path, params: parameters)
        }
        return URLRequest(url: validURL,
                          cachePolicy: .reloadRevalidatingCacheData,
                          timeoutInterval: 10)
    }

}
