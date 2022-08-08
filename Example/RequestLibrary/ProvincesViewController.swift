//
//  ProvincesViewController.swift
//  RequestLibrary_Example
//
//  Created by  Yeskendir Ayat on 02.08.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RequestLibrary
import Moya
import SnapKit

class ProvincesViewController: UIViewController {
    
    var moyaProvider = MoyaProvider<RequestService>(plugins: [CredentialsPlugin { _ -> URLCredential? in URLCredential(user: "ayeskendir08@gmail.com", password: "A_a12345", persistence: .none)}])
    let covidData = CovidData()
    var regionsResult: RegionList?
    var tableView: UITableView!
    var iso:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        getData()
    }
    
    func getData(){
        self.moyaProvider.request(.getProvinces(iso: self.iso)){ [self] (result) in
            switch result{
            case .success(let response):
                self.regionsResult = try! JSONDecoder().decode(RegionList.self, from: response.data)
                self.tableView.reloadData()
                print(response.data)
            case .failure(let err): print(err)
                print("\n getRegions")
            }
        }
    }
}

extension ProvincesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let regionsResult = regionsResult{
            return regionsResult.data.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CitiesViewControllerID") as! CitiesViewController
        vc.iso = regionsResult!.data[indexPath.item].iso
        vc.provinceName = regionsResult!.data[indexPath.item].province
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.label.text = regionsResult!.data[indexPath.item].province
        return cell
    }
}
