//
//  Pulls.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/23/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//


import Foundation

struct Pulls: Decodable {
    
    let title: String
    let state: String
    let diff_url: String
    let number: Int
 
}

