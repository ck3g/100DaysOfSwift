//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Vitali Tatarintev on 24.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var petitions = [Petition]()

  override func viewDidLoad() {
    super.viewDidLoad()

    let urlString: String

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))

    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
      urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }

    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
          self?.parse(json: data)
          return
        }
      }

      self?.showError()
    }
  }

  func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results

      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    petitions.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = petitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.title

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }

  func showError() {
    DispatchQueue.main.async { [weak self] in
      self?.presentAlert(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again")
    }
  }

  @objc func showCredits() {
    presentAlert(title: "Credits", message: "All the data comes from the We The People API of the Whitehouse")
  }

  func presentAlert(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))

    present(ac, animated: true)
  }
}

