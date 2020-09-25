//
//  SectionCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class SectionCell: UITableViewCell {

    var sectionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .label
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.sizeToFit()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //configure(withRow: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(withSectionTitle title: String?) {
        if title != nil {
            self.sectionTitle.text = title
        }else {
            contentView.alpha = 0
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setupView() {
        // Add Sub Views
        self.contentView.addSubview(sectionTitle)
        
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            sectionTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            sectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}

