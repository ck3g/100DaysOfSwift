//
//  ViewController.swift
//  YetAnotherTodoList
//
//  Created by Vitali Tatarintev on 14.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var items = ["Do this", "Do that", "Also, do this", "And also, do that"]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]

    return cell
  }
}

