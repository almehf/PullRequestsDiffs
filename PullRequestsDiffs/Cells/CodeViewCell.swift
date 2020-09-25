//
//  CodeViewCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class CodeViewCell: BaseCell {
    
    let codeNumber = UILabel()
    let code = UILabel()
    
    override func setupViews() {
        setupLayout()
    }
    
    
    func setupLayout(){
        addSubview(code)
        addSubview(codeNumber)
        code.translatesAutoresizingMaskIntoConstraints = false
        codeNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            codeNumber.topAnchor.constraint(equalTo: topAnchor),
            codeNumber.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 5),
            codeNumber.widthAnchor.constraint(equalToConstant: 20),
            codeNumber.heightAnchor.constraint(equalToConstant: 20),
            
            
            code.topAnchor.constraint(equalTo: topAnchor),
            code.leadingAnchor.constraint(equalTo: codeNumber.trailingAnchor),
            code.heightAnchor.constraint(equalToConstant: 20),
            code.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
}

