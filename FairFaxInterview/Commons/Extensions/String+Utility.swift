//
//  String+Utility.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        let first = prefix(1).capitalized
        let other = dropFirst()
        return first + other
    }
}
