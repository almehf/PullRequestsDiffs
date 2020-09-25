//
//  File.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation


struct File: Codable, Hashable {
    
    let filename: String
    let additions: Int
    let deletions: Int
    let changes: Int
    let patch: String

}
