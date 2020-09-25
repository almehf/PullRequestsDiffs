//
//  DiffsViewController.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/25/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class DiffsViewController: UIViewController {
    
    var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = true
        table.tintColor = .green
        return table
    }()
    
    var currentPR: PullViewModel? = nil
    var filesList: [FileViewModel] = []
    var list: [RowViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
    func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}


//*****************************
//MARK: Setup Extension
//*****************************
extension DiffsViewController {
    func setupView() {
        self.view.backgroundColor = .clear
        self.title = "Diffs"
        self.view.addSubview(tableView)
        
        setupTableView()
        makeConstraints()
        fetchFilesData()
        /*
         let fileName = Row(newRow: "", oldRow: "", newLineNumber: 1000, oldLineNumber: 1000, sectionTitle: "", fileName: "FileName\\sfgssfdg_dfbdffb\\sdfbsfb\\sdbsdbsdb.sdfb")
         
         
         let section = Row(newRow: "", oldRow: "", newLineNumber: 1000, oldLineNumber: 1000, sectionTitle: "@@ 21,5 54,4 @@", fileName: "")
         
         
         let test = Row(newRow: "Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text ", oldRow: "Here Old Row Text", newLineNumber: 1000, oldLineNumber: 1000, sectionTitle: "", fileName: "")
         
         let add = Row(newRow: "+ Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text ", oldRow: "Here Old Row Text", newLineNumber: 1000, oldLineNumber: 0, sectionTitle: "", fileName: "")
         
         let delete = Row(newRow: "Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text Here New Row Text ", oldRow: "- Here Old Row Text dfdn dfhn fh dfb ", newLineNumber: 10, oldLineNumber: 100, sectionTitle: "", fileName: "")
         list.append(RowViewModel(row: fileName))
         list.append(RowViewModel(row: section))
         list.append(RowViewModel(row: test))
         list.append(RowViewModel(row: add))
         list.append(RowViewModel(row: test))
         list.append(RowViewModel(row: section))
         list.append(RowViewModel(row: delete))
         list.append(RowViewModel(row: delete))
         list.append(RowViewModel(row: add))
         list.append(RowViewModel(row: add))
         list.append(RowViewModel(row: test))
         
         tableView.reloadData()*/
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FileNameCell.self, forCellReuseIdentifier: "FileCell")
        tableView.register(SectionCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.register(DiffRowCell.self, forCellReuseIdentifier: "DiffCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0),
            
        ])
    }
    
    func fetchFilesData() {
        guard currentPR != nil else { return }
        Service.shared.getFiles(PRNumber: currentPR!.number) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let files) :
                self.filesList = files.map({return FileViewModel(file: $0)})
                
                self.getDiffsFromFiles()
                
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func getDiffsFromFiles() {
        list = []
        for file in filesList {
            //First Row will be File Name
            list.append(RowViewModel(row: Row(newRow: "", oldRow: "", newLineNumber: 0, oldLineNumber: 0, sectionTitle: "", fileName: file.filename)))
            let patchRaws: [String] = file.patch.components(separatedBy: "\n")
            var oldLineNumber = 0
            var newLineNumber = 0
            for row in patchRaws {
                if row.contains("@@") {
                    list.append(RowViewModel(row: Row(newRow: "", oldRow: "", newLineNumber: 0, oldLineNumber: 0, sectionTitle: row, fileName: "")))
                    if let oldRange = row.range(of: "@@ -"), let oldComma = row.range(of: ","), let newRange = row.range(of: "+"), let newComma = row.range(of: ",", options: .backwards) {
                        let old = row[oldRange.upperBound..<oldComma.lowerBound]
                        oldLineNumber = Int(old) ?? 0
                        let new = row[newRange.upperBound..<newComma.lowerBound]
                        newLineNumber = Int(new) ?? 0
                    }
                }else if row.starts(with: "+") {
                    list.append(RowViewModel(row: Row(newRow: row, oldRow: "", newLineNumber: newLineNumber, oldLineNumber: 0, sectionTitle: "", fileName: "")))
                    newLineNumber += 1
                }else if row.starts(with: "-") {
                    list.append(RowViewModel(row: Row(newRow: "", oldRow: row, newLineNumber: 0, oldLineNumber: oldLineNumber, sectionTitle: "", fileName: "")))
                    oldLineNumber += 1
                }else {
                    list.append(RowViewModel(row: Row(newRow: row, oldRow: row, newLineNumber: newLineNumber, oldLineNumber: oldLineNumber, sectionTitle: "", fileName: "")))
                    oldLineNumber += 1
                    newLineNumber += 1
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



//*****************************
//MARK: Table View Extension
//*****************************
extension DiffsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = list[indexPath.row]
        if !row.fileName.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath) as! FileNameCell
            
            cell.configure(withName: list[indexPath.row].fileName)
            return cell
        }else if !row.sectionTitle.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionCell
            
            cell.configure(withSectionTitle: list[indexPath.row].sectionTitle)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiffCell", for: indexPath) as! DiffRowCell
            
            cell.configure(withRow: list[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
