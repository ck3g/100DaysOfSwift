//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Vitali Tatarintev on 08.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  var webView: WKWebView!

  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let url = URL(string: "https://hackingwithswift.com")!
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
  }


}

