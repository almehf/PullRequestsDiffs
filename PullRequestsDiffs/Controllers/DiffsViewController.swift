//
//  DiffsViewController.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class DiffsViewController: UIViewController {
    
    var titleLabel: String?
    var number = 0
    var Difs = [DiffsModel]()
    var diffViewModel = [DiffsViewModel]()
    var diffCellId = "diffCellId"
    var flowLayout = UICollectionViewFlowLayout()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDiffs()
        setupCollectionView()
        setupNavItems()
    }
    
    func setupNavItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target:self, action: #selector(handleDismiss))
    }
    
    @objc func handleDismiss() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupCollectionView (){
        view.addSubview(collectionView)
        flowLayout.itemSize = CGSize(width: view.bounds.width - 20, height: view.bounds.height / 2)
        flowLayout.minimumInteritemSpacing = 10
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.frame =  view.frame
        collectionView.register(DiffCustomCell.self, forCellWithReuseIdentifier: diffCellId)
        collectionView.backgroundColor = .white
        
        
    }
    func fetchDiffs() {
        Service.shared.getDiffs(number : number) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let Diffs) :
                
                print("Diffs count is :\(Diffs.count)")
                self.Difs = Diffs
                self.diffViewModel = Diffs.map({return DiffsViewModel(Dif: $0)})
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Something doesn't seem right", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension DiffsViewController : UICollectionViewDataSource , UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Difs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Ceell", for: indexPath) as! DiffCustomCell
        cell.set(Diff: diffViewModel[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
}

