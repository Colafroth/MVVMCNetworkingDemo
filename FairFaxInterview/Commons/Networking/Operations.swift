//
//  Operations.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

protocol OperationProtocol {
    associatedtype T

    var request: RequestProtocol { get set }

    func execute(in service: ServiceProtocol, onSuccess: ((T) -> Void)?, onError: ErrorHandler?)
}

class JSONOperation<Output: Decodable>: OperationProtocol {
    typealias T = Output

    var request: RequestProtocol

    init(request: RequestProtocol) {
        self.request = request
    }

    func execute(in service: ServiceProtocol, onSuccess: ((Output) -> Void)?, onError: ErrorHandler?) {
        service.execute(request, onSuccess: { response in
            do {
                let output = try JSONDecoder().decode(Output.self, from: response.data)
                onSuccess?(output)
            } catch {
                onError?(error)
            }
        }, onError: { error in
            onError?(error)
        })
    }
}
