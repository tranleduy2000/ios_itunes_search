//
//  ViewController.swift
//  TableView
//
//  Created by Duy on 2/19/18.
//  Copyright © 2018 Duy. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , APIControllerProtocol{
    
    let searchApi: APIController = APIController()
    var tableData = Array<Dictionary<String, String>>()
    let kCellIdentifier: String = "SearchResultCell"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchApi.delagate = self
        searchApi.searchItunesFor(searchTerm: "Angry Birds")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyTestCell")
        
        let app = tableData[indexPath.row]
        cell.textLabel?.text = app[APIController.KEY_APP_NAME]
        cell.detailTextLabel?.text = app[APIController.KEY_PRICE]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row \(indexPath.row)")
        let data = tableData[indexPath.row]
        let image = data[APIController.KEY_THUMBNAIL]
        let name = data[APIController.KEY_APP_NAME]
        let price = data[APIController.KEY_PRICE]
        
        let dialog = UIAlertController(title: name, message: price, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection called return \(tableData.count)")
        return tableData.count
    }
    
    
    func didReceiveApiResults(results: Array<Dictionary<String, String>>) {
        DispatchQueue.main.async {
            self.tableData = results
            self.tableView.reloadData()
        }
    }
    
}

