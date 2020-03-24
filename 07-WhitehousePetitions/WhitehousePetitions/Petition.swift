//
//  Petition.swift
//  WhitehousePetitions
//
//  Created by Vitali Tatarintev on 24.03.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import Foundation

struct Petition: Codable {
  var title: String
  var body: String
  var signatureCount: Int
}
