//
//  DiffCustomCell.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class DiffCustomCell: UICollectionViewCell {
    let infoView = UIView()
    var scrollViewBefore = UIScrollView()
    var scrollViewAfter = UIScrollView()
    let codeViewBefore = UIView()
    let codeViewAfter = UIView()
    let fileName = UILabel()
    let additions = UILabel()
    let deletions = UILabel()
    let changes = UILabel()
    var flowLayout = UICollectionViewFlowLayout()

    let patch = UITextView()
    var beforeAdj : [String] = []
    var afterAdj : [String] = []
    
    lazy var collectionViewBefore: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    lazy var collectionViewAfter: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set (Diff : DiffsViewModel){
        fileName.text =  "File Name : " + Diff.filename
        
        changes.text = "Changes : " + String(Diff.changes)
        additions.text = "Additions : " + String(Diff.additions)
        deletions.text = "Deletions : " + String(Diff.deletions)
        patch.text = Diff.patch
        

        let components = Diff.patch.components(separatedBy: "\n")
        
        for i in components{
            if i.prefix(1) == "+" {
                afterAdj.append(i)
            }
            else if i.prefix(1) == "-" {
                beforeAdj.append(i)
            }
            else {
                afterAdj.append(i)
                beforeAdj.append(i)

            }
            
        }
        


    }
    func layoutUI(){
        
        
        let views = [infoView,scrollViewAfter,fileName,additions,deletions,changes,codeViewAfter,codeViewBefore,patch,collectionViewAfter,scrollViewBefore,collectionViewBefore]
        for view in views{
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(infoView)
        addSubview(scrollViewAfter)
        addSubview(scrollViewBefore)

        infoView.addSubview(fileName)
        infoView.addSubview(changes)
        infoView.addSubview(additions)
        infoView.addSubview(deletions)
        

        scrollViewAfter.addSubview(collectionViewAfter)
        scrollViewBefore.addSubview(collectionViewBefore)

        infoView.backgroundColor = #colorLiteral(red: 0.8661339283, green: 0.8661339283, blue: 0.8661339283, alpha: 1)
        infoView.layer.cornerRadius = 10
        scrollViewAfter.layer.cornerRadius = 10
        scrollViewAfter.backgroundColor = #colorLiteral(red: 0.8587037921, green: 0.8587037921, blue: 0.8587037921, alpha: 1)
        
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: topAnchor),
            infoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 100),
            
            fileName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            fileName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fileName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            fileName.heightAnchor.constraint(equalToConstant: 50),
            
            changes.topAnchor.constraint(equalTo: fileName.topAnchor, constant: 30),
            changes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            changes.heightAnchor.constraint(equalToConstant: 50),
            
            
            additions.topAnchor.constraint(equalTo: fileName.topAnchor, constant: 30),
            additions.centerXAnchor.constraint(equalTo: centerXAnchor),
            additions.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            deletions.topAnchor.constraint(equalTo: fileName.topAnchor, constant: 30),
            deletions.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deletions.heightAnchor.constraint(equalToConstant: 50),
            
           scrollViewBefore.topAnchor.constraint(equalTo: infoView.bottomAnchor , constant: 10),
           scrollViewBefore.leadingAnchor.constraint(equalTo: leadingAnchor),
           scrollViewBefore.widthAnchor.constraint(equalToConstant: bounds.width/2 ),
           scrollViewBefore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
           scrollViewAfter.topAnchor.constraint(equalTo: infoView.bottomAnchor , constant: 10),
           scrollViewAfter.leadingAnchor.constraint(equalTo: scrollViewBefore.trailingAnchor , constant:  10),
           scrollViewAfter.trailingAnchor.constraint(equalTo: trailingAnchor),
           scrollViewAfter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            
            
           collectionViewAfter.topAnchor.constraint(equalTo:   scrollViewAfter.topAnchor ),
           collectionViewAfter.leadingAnchor.constraint(equalTo: scrollViewAfter.leadingAnchor ),
           collectionViewAfter.trailingAnchor.constraint(equalTo: trailingAnchor),
           collectionViewAfter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            

             
             
            collectionViewBefore.topAnchor.constraint(equalTo:   scrollViewBefore.topAnchor ),
            collectionViewBefore.leadingAnchor.constraint(equalTo: scrollViewBefore.leadingAnchor ),
            collectionViewBefore.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewBefore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            

            
        ])
        
        
        scrollViewAfter.delegate = self
        scrollViewAfter.contentSize = CGSize(width: 1000, height: collectionViewAfter.bounds.height)
        
        
        scrollViewBefore.delegate = self
        scrollViewBefore.contentSize = CGSize(width: 1000, height: collectionViewAfter.bounds.height)
        scrollViewAfter.isScrollEnabled = true
        
        collectionViewAfter.delaysContentTouches = true
        flowLayout.itemSize = CGSize(width: 400 , height: 30)
        flowLayout.minimumLineSpacing = 1
        collectionViewAfter.setCollectionViewLayout(flowLayout, animated: true)
        collectionViewAfter.dataSource = self
        collectionViewAfter.register(CodeViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        
        collectionViewBefore.setCollectionViewLayout(flowLayout, animated: true)
        collectionViewBefore.dataSource = self
        collectionViewBefore.register(CodeViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        fileName.lineBreakMode = .byTruncatingMiddle
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.opacity = 0.5
        layer.shadowRadius = 4
        layer.cornerRadius = 10
        layer.masksToBounds = false
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        

    }
    
    
    
    
    
}


extension DiffCustomCell : UICollectionViewDataSource ,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewBefore{
            return beforeAdj.count

        }
            return afterAdj.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CodeViewCell
        
        
        if collectionView == collectionViewBefore{
            cell.code.text = beforeAdj[indexPath.row]
            if beforeAdj[indexPath.row].prefix(1) == "-" {
                cell.backgroundColor = .red
            }
            else {
                cell.backgroundColor = .white

            }
            
            
            return cell
        }
        else {
            cell.code.text = afterAdj[indexPath.row]
            if afterAdj[indexPath.row].prefix(1) == "+" {
                cell.backgroundColor = UIColor.rgb(r: 205, g: 255, b: 216)
            }
            else {
                cell.backgroundColor = .white

            }
            return cell
            
        }


        
        
    }
    

}

