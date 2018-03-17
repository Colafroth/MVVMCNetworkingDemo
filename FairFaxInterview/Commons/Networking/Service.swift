//
//  Service.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 16/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    var configuration: ServiceConfiguration { get }
    var headers: HeadersDictionary { get }
    init(configuration: ServiceConfiguration)
    func execute(_ request: RequestProtocol, onSuccess: ((Response) -> Void)?, onError: ErrorHandler?)
}

struct Service: ServiceProtocol {
    var configuration: ServiceConfiguration
    var headers: HeadersDictionary {
        return configuration.headers
    }

    init(configuration: ServiceConfiguration) {
        self.configuration = configuration
    }

    func execute(_ request: RequestProtocol, onSuccess: ((Response) -> Void)?, onError: ErrorHandler?) {
        var urlRequest: URLRequest!
        do {
            urlRequest = try request.urlRequest(in: self)
        } catch let error as NetworkError {
            onError?(error)
        } catch {
            print(error)
        }

        let dataRequest = Alamofire.request(urlRequest)
        dataRequest.response { defaultDataResponse in
            let response = Response(alamofireResponse: defaultDataResponse)
            switch response.result {
            case .success:
                onSuccess?(response)
            case .error:
                onError?(NetworkError.serverError(response: response))
            case .noResponse:
                onError?(NetworkError.serverNoResponse(response: response))
            }
        }
    }
}
