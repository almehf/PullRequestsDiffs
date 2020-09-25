//
//  PullRequestsTableView.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/24/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class PullRequestsTableView: UITableViewController, URLSessionDelegate {
    
    
    var pullRequests = [PullViewModel]()
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
                
                self.pullRequests = pulls.map({return PullViewModel(pulls: $0)})
                self.filteredPullRequests = self.pullRequests
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
        
        headerView.backgroundColor = .lightGray
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.textAlignment = .center
        label.text = "MagicalRecord"
        label.textColor = UIColor.black // my custom colour
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        setupSegmentedController(headerView: headerView)
        headerView.addSubview(label)
        label.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: headerView.trailingAnchor)
        
        return headerView
    }
    
    
    func setupSegmentedController(headerView: UIView) {
        let items = [#imageLiteral(resourceName: "open"), #imageLiteral(resourceName: "close")]
        let segementedController = UISegmentedControl(items: items)
        segementedController.addTarget(self, action: #selector(toggleState(_:)), for: .valueChanged)
        segementedController.translatesAutoresizingMaskIntoConstraints = false
        segementedController.layer.cornerRadius = 10
        segementedController.layer.borderWidth = 1
        segementedController.backgroundColor = .white
        segementedController.layer.borderColor = UIColor.darkGray.cgColor
        headerView.addSubview(segementedController)
        
        
        segementedController.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: 120, height: 50))
    }
    
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
        filteredPullRequests = self.pullRequests.filter {(pull) -> Bool in
            print(pull.state.rawValue )
            return pull.state.rawValue == RequestState.closed.rawValue
        }
        tableView.reloadData()
    }
    
    
    func fetchOpenedPulls() {
        filteredPullRequests.removeAll()
        filteredPullRequests = self.pullRequests.filter {(pull) -> Bool in
            print(pull.state.rawValue )
            return pull.state.rawValue == RequestState.open.rawValue
        }
        tableView.reloadData()
    }
    
 
    // Show diffs when tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect")
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPullRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PullRequestsCell
        
        let pullRequest = filteredPullRequests[indexPath.item]
        cell.pullRequest = pullRequest
        
        return cell
    }
    
    fileprivate func setupTableView() {
        tableView.register(PullRequestsCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Pull request"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
    static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


