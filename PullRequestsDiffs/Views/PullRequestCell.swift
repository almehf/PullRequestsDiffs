//
//  PullRequestCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/24/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//
import UIKit
class PullRequestsCell: UITableViewCell {


    
    let compareIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "compare-git")?.withTintColor(UIColor.rgb(r: 89, g: 184, b: 105))
        imageView.tintColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = isHighlighted ? .highlightColor : .white
        textLabel?.textColor = isHighlighted ? UIColor.white : .mainTextBlue
        detailTextLabel?.textColor = isHighlighted ? .white : .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // cell customization
        textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        textLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .black
//        detailTextLabel?.text =
        detailTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        imageView?.image = compareIcon.image
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

