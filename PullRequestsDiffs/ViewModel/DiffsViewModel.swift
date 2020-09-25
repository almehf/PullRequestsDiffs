//
//  DiffsViewModel.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation

struct DiffsViewModel: Codable, Hashable {
     let sha, filename, status: String
     let additions, deletions, changes: Int
     let blobURL, rawURL, contentsURL: String
     let patch: String
    
    init(Dif: DiffsModel) {
        self.filename = Dif.filename
        self.status = Dif.status
        self.additions = Dif.additions
        self.changes = Dif.changes
        self.blobURL = Dif.blobURL
        self.rawURL = Dif.rawURL
        self.contentsURL = Dif.contentsURL
        self.patch = Dif.patch
        self.sha = Dif.sha
        self.deletions = Dif.deletions
 
    }
}

