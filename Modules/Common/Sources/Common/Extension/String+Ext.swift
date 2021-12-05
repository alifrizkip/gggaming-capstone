//
//  File.swift
//  
//
//  Created by alip on 05/12/21.
//

import Foundation

extension String {
//  public func localized(identifier: String) -> String {
//    let bundle = Bundle(identifier: identifier) ?? .main
//    return bundle.localizedString(forKey: self, value: nil, table: nil)
//  }
  public func toLocalized() -> String {
//    let bundle = Bundle.module
//    return bundle.localizedString(forKey: self, value: nil, table: nil)
//    let output = NSLocalizedString(self, bundle: Bundle.module, comment: "")
//    return output
    let bundle = Bundle.module
    let output = bundle.localizedString(forKey: self, value: nil, table: nil)

    return output
  }
}
