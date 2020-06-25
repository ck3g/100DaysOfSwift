//
//  Capital.swift
//  CapitalCities
//
//  Created by Vitali Tatarintev on 25.06.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  var info: String

  init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
    self.title = title
    self.coordinate = coordinate
    self.info = info
  }
}
