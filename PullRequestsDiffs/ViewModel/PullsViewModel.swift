//
//  PullsViewModel.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/23/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation

struct PullViewModel: Decodable {
     let title: String
     let state: RequestState
     let diff_url: String
     let number: Int
    
    init(pulls: Pulls) {
        self.title = pulls.title
        self.state = pulls.state
        self.diff_url = pulls.diff_url
        self.number = pulls.number
    }
}

