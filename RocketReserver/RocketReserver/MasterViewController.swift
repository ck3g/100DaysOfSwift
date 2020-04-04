//
//  MasterViewController.swift
//  RocketReserver
//
//  Created by Vitali Tatarintev on 04.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

  }

  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

}

