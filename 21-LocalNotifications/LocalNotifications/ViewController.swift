//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Vitali Tatarintev on 01.07.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
  }

  @objc func registerLocal() {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if granted {
        print("Yay!")
      } else {
        print("D'oh!")
      }
    }
  }

  @objc func scheduleLocal() {
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()

    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "fizzbuzz"]
    content.sound = .default

    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 30
    // Triggers for the specific time
    // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    // Triggers with the time interval
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
  }
}

