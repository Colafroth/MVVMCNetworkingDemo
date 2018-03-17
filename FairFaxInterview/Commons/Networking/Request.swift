//
//  Request.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 16/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var endpoint: String { get set }
    var parameters: ParametersDictionary? { get set }
    var fields: ParametersDictionary? { get set }
    var method: RequestMethod { get set }
    var body: Data? { get set }
    var headers: HeadersDictionary? { get set }
    var cachePolicy: URLRequest.CachePolicy? { get set }
    var timeout: TimeInterval? { get set }
}

extension RequestProtocol {
    func headers(in service: ServiceProtocol) -> HeadersDictionary {
        var headers = service.headers
        self.headers?.forEach {
            headers[$0.key] = $0.value
        }
        return headers
    }

    func url(in service: ServiceProtocol) throws -> URL {
        var urlString = service.configuration.baseURL.absoluteString.appending(endpoint)
        urlString = try urlString.fill(urlParameters: parameters).stringByAppending(fields: fields)
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL(urlString: urlString)
        }
        return url
    }

    func urlRequest(in service: ServiceProtocol) throws -> URLRequest {
        let url = try self.url(in: service)
        let cachePolicy = self.cachePolicy ?? service.configuration.cachePolicy
        let timeout = self.timeout ?? service.configuration.timeout
        let headers = self.headers(in: service)

        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}

struct Request: RequestProtocol {
    var endpoint: String
    var parameters: ParametersDictionary?
    var fields: ParametersDictionary?
    var method: RequestMethod
    var body: Data?
    var headers: HeadersDictionary?
    var cachePolicy: URLRequest.CachePolicy?
    var timeout: TimeInterval?

    init(endpoint: String,
         parameters: ParametersDictionary? = nil,
         fields: ParametersDictionary? = nil,
         method: RequestMethod = .get,
         body: Data? = nil,
         headers: HeadersDictionary? = nil,
         cachePolicy: URLRequest.CachePolicy? = nil,
         timeout: TimeInterval? = nil) {
        self.endpoint = endpoint
        self.parameters = parameters
        self.fields = fields
        self.method = method
        self.body = body
        self.headers = headers
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
}
