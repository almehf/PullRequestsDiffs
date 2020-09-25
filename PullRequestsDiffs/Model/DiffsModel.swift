//
//  DiffsModel.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation

struct DiffsModel: Codable {
    let sha, filename, status: String
    let additions, deletions, changes: Int
    let blobURL, rawURL, contentsURL: String
    let patch: String

    enum CodingKeys: String, CodingKey {
        case sha, filename, status, additions, deletions, changes
        case blobURL = "blob_url"
        case rawURL = "raw_url"
        case contentsURL = "contents_url"
        case patch
    }
}


