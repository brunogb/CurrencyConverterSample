//
//  Requester.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

class RequestToken {
    private let task: URLSessionTask

    fileprivate init(_ task: URLSessionTask) {
        self.task = task
    }

    deinit {
        task.cancel()
    }
}

protocol Requester {
    typealias Callback<R> = (Result<R>)-> Void
    func request<R>(resource: JSONResource<R>, callback: @escaping Callback<R>)-> RequestToken? where R: Decodable
}

class URLRequester: Requester {

    static let `default`: Requester = URLRequester(base: URL(string: "https://revolut.duckdns.org")!)

    enum NetworkError: Error {
        case missingData
    }

    private let session: URLSession
    private let base: URL

    init(session: URLSession = URLSession.shared, base: URL) {
        self.session = session
        self.base = base
    }

    func request<R>(resource: JSONResource<R>, callback: @escaping Callback<R>)-> RequestToken? where R: Decodable {
        do {
            let urlRequest = try resource.urlRequest(base: base)
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                let result: Result<R>
                defer {
                    callback(result)
                }
                if let error = error {
                    result = .error(error)
                    return
                }
                guard let data = data else {
                    result = .error(NetworkError.missingData)
                    return
                }
                do {
                    let model = try resource.decoder.decode(R.self, from: data)
                    result = .success(model)
                }
                catch (let error) {
                    result = .error(error)
                }
            }
            task.resume()
            return RequestToken(task)
        }
        catch (let requestError) {
            callback(.error(requestError))
            return nil
        }
    }

}
