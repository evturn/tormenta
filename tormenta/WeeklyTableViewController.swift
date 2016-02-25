//
//  WeeklyTableViewController.swift
//  tormenta
//
//  Created by Evan Turner on 2/25/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.backgroundView = BackgroundView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
}
