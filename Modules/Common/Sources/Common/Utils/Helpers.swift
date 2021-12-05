//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Foundation

public enum Helpers {
  public static func convertGameReleasedText(_ input: String?) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"

    guard let releaseDate = input, let date = dateFormatter.date(from: releaseDate) else {
      return "n/a"
    }

    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter.string(from: date)
  }
}
