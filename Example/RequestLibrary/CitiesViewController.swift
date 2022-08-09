//
//  CitiesViewController.swift
//  RequestLibrary_Example
//
//  Created by  Yeskendir Ayat on 04.08.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import RequestLibrary

// last VC is represent cities with confirmed sick and deaths.

class CitiesViewController: UIViewController {
    
    var moyaProvider = MoyaProvider<RequestService>(plugins: [CredentialsPlugin { _ -> URLCredential? in URLCredential(user: "ayeskendir08@gmail.com", password: "A_a12345", persistence: .none)}])
    let covidData = CovidData()
    var provinceName:String!
    var iso:String!
    var regionsResult:[City] = []
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        getData()
    }
    
    func getData(){
        self.moyaProvider.request(.getRegionCities(regionName: provinceName)){
            [self] (result) in
            switch result{
            case .success(let response):
                if response.data.isEmpty{return}
                let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [String:Any]
                let data = (((json["data"] as! NSArray)[0] as! [String:Any])["region"] as! [String:Any])["cities"] as! NSArray
                if data.count == 0 {return}
                for i in data{
                    regionsResult.append(City(json: i as! [String : Any])!)
                    self.tableView.reloadData()
                }
                
                self.tableView.reloadData()
                case .failure(let err): print(err)
            }
        }
    }
}


extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if regionsResult.isEmpty{return 0}
        return regionsResult.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.label.text = "\(regionsResult[indexPath.item].name) : confirmed: \(String(regionsResult[indexPath.item].confirmed))  | death: \(String(regionsResult[indexPath.item].deaths))"
        return cell
    }
}
