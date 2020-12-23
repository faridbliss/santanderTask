//
//  Encodable+asDict.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import PMJSON

extension Encodable {

  func asDictionary() throws -> [String: Any] {
    return try PMJSON.JSON.Encoder().encodeAsJSON(self).ns as! [String: Any]
  }

}
