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
    var result: Response.Result { get }
    var httpResponse: HTTPURLResponse? { get }
    var statusCode: Int? { get }
    var data: Data! { get }
}

struct Response: ResponseProtocol {
    enum Result {
        case success(statusCode: Int)
        case error(statusCode: Int)
        case noResponse

        static func make(response: DefaultDataResponse) -> Result {
            guard let httpResponse = response.response else { return .noResponse }
            guard response.error == nil,
                response.data != nil else { return .error(statusCode: httpResponse.statusCode) }
            return .success(statusCode: httpResponse.statusCode)
        }
    }

    var result: Result
    var httpResponse: HTTPURLResponse?
    var statusCode: Int?
    var data: Data!

    init(alamofireResponse: DefaultDataResponse) {
        self.result = Result.make(response: alamofireResponse)
        self.httpResponse = alamofireResponse.response
        self.statusCode = alamofireResponse.response?.statusCode
        self.data = alamofireResponse.data
    }
}
