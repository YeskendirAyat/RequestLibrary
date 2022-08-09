//
//  RequestService.swift
//  RequestLibrary
//
//  Created by  Yeskendir Ayat on 03.08.2022.
//

import Foundation
import Moya

// RequestService is my

extension RequestService: TargetType{
    
    public var baseURL: URL {
        guard let url = URL(string:
                            "https://covid-19-statistics.p.rapidapi.com"
        ) else {
            fatalError()
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .getTotalData:
            return "/reports/total"
        case .getRegions:
            return "/regions"
        case .getProvinces:
            return "/provinces"
        case .getCityInfo, .getRegionCities:
            return "/reports"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getRegions, .getTotalData, .getProvinces, .getCityInfo, .getRegionCities:
                return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getRegions, .getTotalData:
            return .requestPlain
        case .getProvinces(let iso):
            return .requestParameters(parameters: ["iso": iso], encoding: URLEncoding.queryString)
        case .getCityInfo(let cityName, let regionProvince):
            return .requestParameters(parameters: ["city_name":cityName, "region_province":regionProvince], encoding: URLEncoding.queryString)
        case .getRegionCities(let regionName):
            return .requestParameters(parameters: ["region_province":regionName], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return [
                "X-RapidAPI-Key": "5d2a43d2aamsh0c3cd83b77b86e4p107fbbjsn9e6cd0813fa4",
                "X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com"
        ]
    }
    
    public var sampleData: Data{
        switch self {
        case .getTotalData, .getCityInfo, .getRegions, .getProvinces, .getRegionCities:
                return Data()
        }
    }
}

