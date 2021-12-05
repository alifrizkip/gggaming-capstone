//
//  File.swift
//  
//
//  Created by alip on 05/12/21.
//

import Foundation

extension String {
  public func toLocalized() -> String {
    NSLocalizedString(self, bundle: Bundle.module, comment: "")
  }
}
