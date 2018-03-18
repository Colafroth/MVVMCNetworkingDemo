//
//  Response.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation
import Alamofire

protocol ResponseProtocol {
    var result: ResponseResult { get }
    var httpResponse: HTTPURLResponse? { get }
    var statusCode: Int? { get }
    var data: Data! { get }
    var request: RequestProtocol { get }
}

enum ResponseResult {
    case success(statusCode: Int)
    case error(statusCode: Int)
    case noResponse

    static func make(response: DefaultDataResponse) -> ResponseResult {
        guard let httpResponse = response.response else { return .noResponse }
        guard response.error == nil,
            response.data != nil else { return .error(statusCode: httpResponse.statusCode) }
        return .success(statusCode: httpResponse.statusCode)
    }
}

struct Response: ResponseProtocol {
    // MARK: - Properties
    var result: ResponseResult
    var httpResponse: HTTPURLResponse?
    var statusCode: Int?
    var data: Data!
    var request: RequestProtocol

    // MARK: - Inits
    init(alamofireResponse: DefaultDataResponse, request: RequestProtocol) {
        self.result = ResponseResult.make(response: alamofireResponse)
        self.httpResponse = alamofireResponse.response
        self.statusCode = alamofireResponse.response?.statusCode
        self.data = alamofireResponse.data
        self.request = request
    }
}
