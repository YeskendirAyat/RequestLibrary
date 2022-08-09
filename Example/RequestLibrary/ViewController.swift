//
//  ViewController.swift
//  RequestLibrary
//
//  Created by YeskendirAyat on 07/27/2022.
//  Copyright (c) 2022 YeskendirAyat. All rights reserved.
//

import UIKit
import RequestLibrary
import Moya
import RxSwift

// COVID-19 data where you can see in which city how many people are sick now, and how many deaths until today.
// First VC presented list of counties.

// API link: https://rapidapi.com/axisbits-axisbits-default/api/covid-19-statistics/

class ViewController: UIViewController{
    
    let moyaProvider = MoyaProvider<RequestService>(plugins: [CredentialsPlugin { _ -> URLCredential? in URLCredential(user: "ayeskendir08@gmail.com", password: "A_a12345", persistence: .none)}])
    
    let covidData = CovidData()
    var regionsResult: CountryList?
    var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView = UITableView(frame: .zero)
        self.navigationController?.navigationBar.topItem?.title="Covid-19"
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
        self.moyaProvider.request(.getRegions){ [self] (result) in
            switch result{
            case .success(let response):
                self.regionsResult = try! JSONDecoder().decode(CountryList.self, from: response.data)
                self.tableView.reloadData()
            case .failure(let err): print(err)
                print("\n getRegions")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let regionsResult = regionsResult{
            return regionsResult.data.count
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProvincesViewControllerID") as! ProvincesViewController
        vc.iso = regionsResult!.data[indexPath.item].iso
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.label.text = regionsResult!.data[indexPath.item].name
        return cell
    }
}
