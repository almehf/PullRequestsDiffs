//
//  Row.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation

struct Row: Codable, Hashable {
    
    let newRow: String
    let oldRow: String
    let newLineNumber: Int
    let oldLineNumber: Int
    let sectionTitle: String
    let fileName: String
}
