//
//  ServiceConfiguration.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 15/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

private struct Constants {
    static let environmentKey = "Environment"
    static let nameKey = "Name"
    static let baseURLKey = "BaseURL"
}

public final class ServiceConfiguration {
    // MARK: - Properties
    private(set) var name: String
    private(set) var baseURL: URL
    private(set) var headers = HeadersDictionary()
    private(set) var timeout: TimeInterval = 10
    private(set) var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy

    // MARK: - Inits
    init?(name: String, baseURLString: String) {
        guard let baseURL = URL(string: baseURLString) else { return nil }
        self.name = name
        self.baseURL = baseURL
    }

    convenience init?() {
        guard let endpointDictionary = Bundle.main.object(forInfoDictionaryKey: Constants.environmentKey) as? [String: Any],
            let name = endpointDictionary[Constants.nameKey] as? String,
            let baseURLString = endpointDictionary[Constants.baseURLKey] as? String else { return nil }

        self.init(name: name, baseURLString: baseURLString)
    }

    static func make() -> ServiceConfiguration {
        let config = ServiceConfiguration()
        return config!
    }
}
