//
//  Dictionary+URL.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 17/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    public func urlFieldsString(with baseURLString: String = "") throws -> String {
        guard !isEmpty else { return "" }
        let items: [URLQueryItem] = self.flatMap {
            return URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        guard var urlComponents = URLComponents(string: baseURLString) else {
            throw NetworkError.fieldsNotEncodable
        }
        urlComponents.queryItems = items

        guard let urlFieldsString = urlComponents.url else {
            throw NetworkError.fieldsNotEncodable
        }
        
        return urlFieldsString.absoluteString
    }
}

