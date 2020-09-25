//
//  DiffRowCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class DiffRowCell: UITableViewCell {

    var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var oldView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var newView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var additionsHighlight: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3354109895, green: 1, blue: 0.5122905478, alpha: 0.5968371976)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var deletionsHighlight: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.2085311723, blue: 0.1386840817, alpha: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var oldNumberLine: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "American Typewriter", size: 14)
        label.textColor =  .secondaryLabel
        label.backgroundColor = .clear
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.sizeToFit()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var newNumberLine: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "American Typewriter", size: 14)
        label.textColor =  .secondaryLabel
        label.backgroundColor = .clear
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.sizeToFit()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var oldTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "American Typewriter", size: 14)
        label.textColor =  .label
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.sizeToFit()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var newTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "American Typewriter", size: 14)
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(withRow row: RowViewModel?) {
        if row != nil {
            if row!.oldRow.starts(with: "-") {
                deletionsHighlight.isHidden = false
            }else {
                deletionsHighlight.isHidden = true
            }
            
            if row!.newRow.starts(with: "+") {
                additionsHighlight.isHidden = false
            }else {
                additionsHighlight.isHidden = true
            }
            self.oldTitle.text = row!.oldRow
            self.newTitle.text = row!.newRow
            self.oldNumberLine.text = row!.oldLineNumber == 0 ? "" : "\(row!.oldLineNumber)"
            self.newNumberLine.text = row!.newLineNumber == 0 ? "" : "\(row!.newLineNumber)"
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
        // Add SubViews
        self.contentView.addSubview(additionsHighlight)
        self.contentView.addSubview(deletionsHighlight)
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(divider)


        stackView.addArrangedSubview(oldView)
        oldView.addSubview(oldNumberLine)
        oldView.addSubview(oldTitle)

        stackView.addArrangedSubview(newView)
        newView.addSubview(newNumberLine)
        newView.addSubview(newTitle)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            divider.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            divider.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            divider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            divider.widthAnchor.constraint(equalToConstant: 2),
            
            oldView.topAnchor.constraint(equalTo: stackView.topAnchor),
            oldView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            oldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),

            newView.topAnchor.constraint(equalTo: stackView.topAnchor),
            newView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            newView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            deletionsHighlight.topAnchor.constraint(equalTo: oldView.topAnchor),
            deletionsHighlight.bottomAnchor.constraint(equalTo: oldView.bottomAnchor),
            deletionsHighlight.leadingAnchor.constraint(equalTo: oldView.leadingAnchor),
            deletionsHighlight.trailingAnchor.constraint(equalTo: oldView.trailingAnchor),

            additionsHighlight.topAnchor.constraint(equalTo: newView.topAnchor),
            additionsHighlight.bottomAnchor.constraint(equalTo: newView.bottomAnchor),
            additionsHighlight.leadingAnchor.constraint(equalTo: newView.leadingAnchor),
            additionsHighlight.trailingAnchor.constraint(equalTo: newView.trailingAnchor),
            
            oldNumberLine.topAnchor.constraint(equalTo: oldView.topAnchor),
            oldNumberLine.leadingAnchor.constraint(equalTo: oldView.leadingAnchor),
            oldNumberLine.widthAnchor.constraint(equalToConstant: 40),
            
            oldTitle.topAnchor.constraint(equalTo: oldView.topAnchor),
            oldTitle.bottomAnchor.constraint(lessThanOrEqualTo: oldView.bottomAnchor),
            oldTitle.trailingAnchor.constraint(equalTo: oldView.trailingAnchor),
            oldTitle.leadingAnchor.constraint(equalTo: oldNumberLine.trailingAnchor),

            newNumberLine.topAnchor.constraint(equalTo: newView.topAnchor),
            newNumberLine.leadingAnchor.constraint(equalTo: newView.leadingAnchor),
            newNumberLine.widthAnchor.constraint(equalToConstant: 40),
            
            newTitle.topAnchor.constraint(equalTo: newView.topAnchor),
            newTitle.bottomAnchor.constraint(lessThanOrEqualTo: newView.bottomAnchor),
            newTitle.trailingAnchor.constraint(equalTo: newView.trailingAnchor),
            newTitle.leadingAnchor.constraint(equalTo: newNumberLine.trailingAnchor),
        ])
    }
}

