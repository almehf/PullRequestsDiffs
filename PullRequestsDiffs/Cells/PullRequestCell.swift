//
//  PullRequestCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/24/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//
import UIKit
class PullRequestsCell: UITableViewCell {

    
    var pullRequest: PullViewModel! {
        didSet {
            textLabel?.text = pullRequest.title
            detailTextLabel?.text = "#\(String(pullRequest.number))"
        }
    }

    
    let compareIcon: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
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
        textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        imageView?.layer.cornerRadius = 5
        imageView?.layer.borderWidth = 1
        imageView?.layer.borderColor = UIColor.lightGray.cgColor
        imageView?.image = compareIcon.image

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

