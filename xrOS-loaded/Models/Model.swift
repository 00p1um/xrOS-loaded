//
//  Model.swift
//  xrOS-loaded
//
//  Created by Rayan Khan on 6/21/23.
//

import Foundation
import Combine
import SwiftUI

struct ESign: Decodable, Hashable {

    let name: String
    let identifier: String?
    let sourceURL: String?
    let sourceImage: String?
    let sourceDescription: String?
    var apps: [Apps]
    
}

struct Apps: Decodable, Hashable, Identifiable {
    var id: String { name }

    var source: String?
    let name: String
    let bundleIdentifier: String?
    let developerName: String?
    let version: String?
    let versionDate: String?
    let versionDescription: String?
    let downloadURL: String?
    let localizedDescription: String?
    let iconURL: String?
    let imageURL: String?
    let tintColor: String?
    let size: Int?
    let screenshotURLs: [String]?
}


struct Repo: Identifiable {
    let id: Int
    let name: String
    let url: URL
}
