//
//  Person.swift
//  NamesToFaces
//
//  Created by Vitali Tatarintev on 29.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
  var name: String
  var image: String

  init(name: String, image: String) {
    self.name = name
    self.image = image
  }

  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
  }

  func encode(with coder: NSCoder) {
    coder.encode(name, forKey: "name")
    coder.encode(image, forKey: "image")
  }
}
