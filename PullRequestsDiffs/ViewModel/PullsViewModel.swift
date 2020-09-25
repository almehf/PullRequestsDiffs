//
//  PullsViewModel.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/23/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation

struct PullViewModel:  Codable, Hashable {
    
     let title: String
     let state: RequestState
     let diff_url: String
     let number: Int
    
    init(pull: Pull) {
        self.title = pull.title
        self.state = pull.state
        self.diff_url = pull.diff_url
        self.number = pull.number
    }
}

