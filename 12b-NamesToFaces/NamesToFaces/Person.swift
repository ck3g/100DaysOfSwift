//
//  Person.swift
//  NamesToFaces
//
//  Created by Vitali Tatarintev on 29.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
  var name: String
  var image: String

  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
