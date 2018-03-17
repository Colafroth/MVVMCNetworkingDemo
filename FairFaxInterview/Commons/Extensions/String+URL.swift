//
//  String+URL.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

extension String {
    func fill(urlParameters: ParametersDictionary?) -> String {
        guard let urlParameters = urlParameters else { return self }
        var string = self
        urlParameters.forEach {
            string = string.replacingOccurrences(of: "{\($0.key)}", with: String(describing: $0.value))
        }
        return string
    }

    func stringByAppending(fields: ParametersDictionary?) throws -> String {
        guard let fields = fields else { return self }
        return try fields.urlFieldsString(with: self)
    }
}
