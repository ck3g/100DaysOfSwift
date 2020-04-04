//
//  DetailViewController.swift
//  RocketReserver
//
//  Created by Vitali Tatarintev on 04.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit
import Apollo

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!

  var launchID: GraphQLID? {
    didSet {
      self.configureView()
    }
  }


  func configureView() {
    guard let label = self.detailDescriptionLabel, let id = self.launchID else { return }

    label.text = "Launch \(id)"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureView()
  }

}

