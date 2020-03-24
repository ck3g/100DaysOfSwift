//
//  DetailViewController.swift
//  WhitehousePetitions
//
//  Created by Vitali Tatarintev on 24.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  var webView: WKWebView!
  var detailItem: Petition?

  override func loadView() {
    webView = WKWebView()
    view = webView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let detailItem = detailItem else { return }

    let html = """
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
      </head>
      <body>
        <h3>\(detailItem.title)</h3>
        <div>
          \(detailItem.body)
        </div>
      </body>
    </html>
    """

    webView.loadHTMLString(html, baseURL: nil)
  }

}
