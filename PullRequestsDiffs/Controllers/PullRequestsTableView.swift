//
//  PullRequestsTableView.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/24/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class PullRequestsTableView: UITableViewController, URLSessionDelegate {
    
    
    var pullViewModel = [PullViewModel]()
    var filteredPullRequests = [PullViewModel]()
    fileprivate let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        fetchPullRequests()
    }
    
    func fetchPullRequests() {
        Service.shared.getPulls { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let pulls) :
                
                self.pullViewModel = pulls.map({return PullViewModel(pull: $0)})
                self.filteredPullRequests = self.pullViewModel
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 100))
        headerView.backgroundColor = UIColor.rgb(r: 50, g: 147, b: 234)
        setupSegmentedController(headerView: headerView)
        return headerView
    }
    
    
    func setupSegmentedController(headerView: UIView) {
        let items = [#imageLiteral(resourceName: "open"), #imageLiteral(resourceName: "close")]
        let segementedController = UISegmentedControl(items: items)
        segementedController.addTarget(self, action: #selector(toggleState(_:)), for: .valueChanged)
        segementedController.translatesAutoresizingMaskIntoConstraints = false
        segementedController.layer.cornerRadius = 10
        segementedController.layer.borderWidth = 1
        segementedController.selectedSegmentIndex = 0
        segementedController.backgroundColor = .white
        segementedController.layer.borderColor = UIColor.darkGray.cgColor
        headerView.addSubview(segementedController)
        
        
        segementedController.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: 120, height: 50))
    }
    
    // Toggle state of pull (Open - Closed)
    @objc func toggleState(_ segmentedController: UISegmentedControl) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            fetchOpenedPulls()
        case 1:
            fetchClosedPulls()
        default:
            print("default")
        }
    }
    
    
    func fetchClosedPulls() {
        filteredPullRequests.removeAll()
        filteredPullRequests = self.pullViewModel.filter {(pull) -> Bool in
            print(pull.state.rawValue )
            return pull.state.rawValue == RequestState.closed.rawValue
        }
        tableView.reloadData()
    }
    
    
    func fetchOpenedPulls() {
        filteredPullRequests.removeAll()
        filteredPullRequests = self.pullViewModel.filter {(pull) -> Bool in
            print(pull.state.rawValue )
            return pull.state.rawValue == RequestState.open.rawValue
        }
        tableView.reloadData()
    }
    
    
    fileprivate func setupTableView() {
        tableView.register(PullRequestsCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 238, g: 238, b: 238)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "MagicalRecord"
        navigationController?.navigationBar.prefersLargeTitles = true
        //        UIColor.rgb(r: 50, g: 147, b: 234)
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(r: 50, g: 147, b: 234)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 147, b: 234)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PullRequestsTableView {
    
    // setup TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPullRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PullRequestsCell
        
        let pullRequest = filteredPullRequests[indexPath.item]
        cell.pullRequest = pullRequest
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // setup TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pullReq = pullViewModel[indexPath.row]
        let viewController = DiffsViewController()
        viewController.currentPR = pullReq
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
