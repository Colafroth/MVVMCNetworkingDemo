//
//  NetworkingCommon.swift
//  MVVMCNetworkingDemo
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

typealias ParametersDictionary = [String: Any]
typealias HeadersDictionary = [String: String]

typealias ErrorHandler = ((Error) -> Void)

enum RequestMethod: String {
    case get    = "GET"
    case post    = "POST"
    case put    = "PUT"
    case delete    = "DELETE"
    case patch    = "PATCH"
}

enum NetworkError: Error {
    case fieldsNotEncodable
    case invalidURL(urlString: String)
    case serverError(response: ResponseProtocol)
    case serverNoResponse(response: ResponseProtocol)
}
