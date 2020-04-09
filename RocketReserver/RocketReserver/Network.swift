//
//  Network.swift
//  RocketReserver
//
//  Created by Vitali Tatarintev on 04.04.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import Foundation
import Apollo
import KeychainSwift

class Network {
  static let shared = Network()

  // private(set) lazy var apollo = ApolloClient(url: URL(string: "https://n1kqy.sse.codesandbox.io/")!)
  private(set) lazy var apollo: ApolloClient = {
    let httpNetworkTransport = HTTPNetworkTransport(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/")!)
    httpNetworkTransport.delegate = self
    return ApolloClient(networkTransport: httpNetworkTransport)
  }()
}

extension Network: HTTPNetworkTransportPreflightDelegate {
  func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
    return true
  }

  func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
    let keychain = KeychainSwift()
    if let token = keychain.get(LoginViewController.loginKeychainKey) {
      request.addValue(token, forHTTPHeaderField: "Authorization")
    } // else do nothing
  }
}
