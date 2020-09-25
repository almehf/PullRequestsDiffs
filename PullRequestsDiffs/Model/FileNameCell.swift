//
//  FileNameCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class FileNameCell: UITableViewCell {

    var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .firstBaseline
        view.distribution = .fillProportionally
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .gray
        label.text = "File Name: "
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.sizeToFit()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(withName name: String?) {
        if name != nil {
            self.nameValue.text = name
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
        self.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        // Add Sub Views
        self.contentView.addSubview(stackView)
        self.stackView.addArrangedSubview(nameLabel)
        self.stackView.addArrangedSubview(nameValue)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: stackView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 80.0),
 
            nameValue.topAnchor.constraint(equalTo: stackView.topAnchor),
            nameValue.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            nameValue.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

        ])
    }
}

