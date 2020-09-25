//
//  BaseCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell, UINavigationControllerDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
 


