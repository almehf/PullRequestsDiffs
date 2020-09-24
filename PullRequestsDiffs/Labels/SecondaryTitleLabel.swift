//
//  SecondaryTitleLabel.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/23/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class SecondaryTitleLabel: UILabel {

    // MARK: - Initializers

   override init(frame: CGRect) {
       super.init(frame: frame)
       configure()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   init(fontSize: CGFloat) {
       super.init(frame: .zero)
    font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
       configure()
   }
   
   // MARK: - Internal
   
   private func configure() {
       textColor = .secondaryLabel
       adjustsFontSizeToFitWidth = true
       minimumScaleFactor = 0.90
       lineBreakMode = .byTruncatingTail
       translatesAutoresizingMaskIntoConstraints = false
   }
}

