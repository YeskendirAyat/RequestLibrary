

import Moya
import Foundation

public enum RequestService{
    case getTotalData
    case getRegions
    case getProvinces(iso: String)
    case getRegionCities(regionName: String)
    case getCityInfo(cityName: String, regionProvince: String)
}

// class CovidData responsible for request and response
// Why i don't use is realization? Cause 

public class CovidData{
    var countryResults: CountryList?
    var results: CountryList = CountryList(data: [])
    var moyaProvider = MoyaProvider<RequestService>(plugins: [CredentialsPlugin { _ -> URLCredential? in URLCredential(user: "ayeskendir08@gmail.com", password: "A_a12345", persistence: .none)}])
    
    public init(){}
    
    public func totalResult(){
        moyaProvider.request(.getTotalData){ (result) in
            switch result{
            case .success(let response):
                let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [String:Any]
                print(json)
            case .failure(let err): print(err)
            }
        }
    }
    public func getRegions()  -> CountryList{
            self.moyaProvider.request(.getRegions){ [self] (result) in
                switch result{
                case .success(let response):
                    self.results = try! JSONDecoder().decode(CountryList.self, from: response.data)
                case .failure(let err): print(err)
                    print("\n getRegions")
                }
            }
        return results
    }
    
    public func getProvincesByName(iso:String){
        moyaProvider.request(.getProvinces(iso: iso)){ (result) in
            switch result{
            case .success(let response):
                let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [Country]
                print(json.count)
            case .failure(let err): print(err)
            }
        }
    }
    
    public func regionResult(regionName:String){
        moyaProvider.request(.getRegionCities(regionName: regionName)){ (result) in
            switch result{
            case .success(let response):
                let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [String:Any]
                print(json)
            case .failure(let err): print(err)
            }
        }
    }
    
    public func cityResult(cityName:String ,regionProvince:String){
        moyaProvider.request(.getCityInfo(cityName: cityName, regionProvince: regionProvince)){ (result) in
            switch result{
            case .success(let response):
                let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [String:Any]
                print(json)
            case .failure(let err): print(err)
            }
        }
    }
}

public struct CountryList:Codable{                        
    public var data:[Country]
}

public struct Country: Codable {
    public var iso: String
    public var name: String
}
