//
//  ViewController.swift
//  DetectABeacon
//
//  Created by Vitali Tatarintev on 02.07.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
  @IBOutlet var distanceReading: UILabel!

  var locationManager: CLLocationManager?

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization()
    // locationManager?.requestWhenInUseAuthorization() // Alternatively

    view.backgroundColor = .gray
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
        if CLLocationManager.isRangingAvailable() {
          // do stuff
        }
      }
    }
  }
}

