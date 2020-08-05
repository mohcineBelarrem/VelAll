//
//  ViewController.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 04/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var contracts = [String:[Contract]]()
    
    @IBOutlet weak var tableView: UITableView!
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return contracts.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let country = Array(contracts.keys)[section]
        return contracts[country]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell")
        
        let country = Array(contracts.keys)[indexPath.section]
        
        let contract = contracts[country]?[indexPath.row]
        
        cell?.textLabel?.text = contract?.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(contracts.keys)[section]
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
        DataRetriever.fetchContracts() { result in
         
            switch result {
            
            case .success(let contractsList):
                self.mapContractsUsingCountries(contractsList: contractsList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            
            case.failure(_):
                //TODO: Show some feedback
                print("Error")
            }
        }
        
    }
    
    func mapContractsUsingCountries(contractsList : [Contract]) {
        
        for contract in contractsList {
            if self.contracts.keys.contains(contract.countryCode) {
                var contractsForCountry = self.contracts[contract.countryCode]
                contractsForCountry?.append(contract)
                
                self.contracts[contract.countryCode] = contractsForCountry!
                
            } else {
                self.contracts[contract.countryCode] = [contract]
            }
        }
    }

}




