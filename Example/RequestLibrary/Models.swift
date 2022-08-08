//
//  Models.swift
//  RequestLibrary_Example
//
//  Created by  Yeskendir Ayat on 05.08.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Moya

public struct RegionList:Codable{
    public var data:[Region]
}

public struct Region: Codable {
    public var iso: String
    public var name: String
    public var province: String
}

public struct City {
    public let name: String
    public let confirmed: Int
    public let deaths: Int
    init?(json: [String: Any]) {
        let name = json["name"] as! String
        let confirmed = json["confirmed"] as! Int
        let deaths = json["deaths"] as! Int
        self.name = name
        self.confirmed = confirmed
        self.deaths = deaths
    }
}
