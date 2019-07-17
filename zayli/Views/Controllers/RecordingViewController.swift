//
//  RecordingViewController.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftySound

class RecordingViewController: UITableViewController {
    
    private var practice: Practice?
    private var records: Results<Record>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
    }
    
    func setupData(){
        let id = getTempId()
        
        practice = Realm.shared.object(ofType: Practice.self, forPrimaryKey: id)
        records = practice?.records.sorted(byKeyPath: "timestamp", ascending: false)
    }
    
    func setupUI(){
        title = practice?.idea
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension RecordingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordingViewTableViewCell
        let record = records?[indexPath.row] as! Record
        let number = records!.count - indexPath.row
        
        cell.populate(record, number)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = records?[indexPath.row]
        
        setTempId(record!.id, key: "recordId")
        performSegue(withIdentifier: "GoFeedbackList", sender: nil)
        
//        Sound.play(url: url)
        
    }
    
}
