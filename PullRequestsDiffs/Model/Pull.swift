//
//  Pull.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation

enum RequestState : String, Codable {
    case closed = "closed"
    case open   = "open"
}

struct Pull: Codable, Hashable {
    
    let title: String
    let state: RequestState
    let diff_url: String
    let number: Int
    
}
