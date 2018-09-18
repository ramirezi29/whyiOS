//
//  Model.swift
//  whyiOS
//
//  Created by Ivan Ramirez on 9/11/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct Post: Codable {
    let name: String
    let reason: String
    let cohort: String = "iOS 21"
}
