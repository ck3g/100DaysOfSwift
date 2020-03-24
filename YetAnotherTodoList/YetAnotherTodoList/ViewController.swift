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

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoItem))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearItemsList))
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]

    return cell
  }

  @objc func addTodoItem() {
    let ac = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
      guard let newItem = ac?.textFields?[0].text else { return }

      self?.items.append(newItem)
      self?.tableView.reloadData()
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
  }

  @objc func clearItemsList() {
    items.removeAll()
    tableView.reloadData()
  }
}

