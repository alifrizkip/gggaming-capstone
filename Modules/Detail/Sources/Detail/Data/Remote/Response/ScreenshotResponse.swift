//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

public struct ScreenshotResponse: Codable {
  let id: Int
  let image: String
}

public struct ScreenshotsListResponse: Codable {
  let results: [ScreenshotResponse]
}
