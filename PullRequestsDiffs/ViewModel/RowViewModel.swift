//
//  RowViewModel.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import Foundation
import UIKit

struct RowViewModel: Codable, Hashable {
    let newRow: String
    let oldRow: String
    let newLineNumber: Int
    let oldLineNumber: Int
    let sectionTitle: String
    let fileName: String
    init(row: Row) {
        self.newRow = row.newRow
        self.oldRow = row.oldRow
        self.newLineNumber = row.newLineNumber
        self.oldLineNumber = row.oldLineNumber
        self.sectionTitle = row.sectionTitle
        self.fileName = row.fileName
    }
}


