//
//  AllCityVC.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 20/08/21.
//

import UIKit
import ObjectMapper
import Alamofire

class AllCityVC: UIViewController {

    @IBOutlet weak var tblAllCity: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var responseAllCity : [AllCityModel] = [AllCityModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tblAllCity.delegate = self
        tblAllCity.dataSource = self
        tblAllCity.register(AllCityCell.nib, forCellReuseIdentifier: AllCityCell.identifier)
        apiCalling()
    }

}


extension AllCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseAllCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCityCell.identifier, for: indexPath) as! AllCityCell
        let obj = responseAllCity[indexPath.row]
        cell.setData(obj: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension AllCityVC {
    
    func apiCalling() {
        
                if NetworkReachabilityManager()!.isReachable {
                    let url = URL(string: "https://api.npoint.io/c4683decc7df639018f6")
        
                    AF.request(url!, method: .get, parameters: [:]).responseJSON { (response) in
                        switch response.result {
        
                        case .success(let value):
                            if let responseArray = value as? [Any] {
                                if response.response?.statusCode == 200 {
                                    #if DEBUG
                                    print("Success with JSON: \(responseArray)")
                                    #endif
                                    if let dataResponse = Mapper<AllCityModel>().mapArray(JSONObject: value) {
                                        self.responseAllCity = dataResponse
                                        self.tblAllCity.reloadData()
                                    }
                                } else {
                                    print("Something went wrong")
                                }
                            }
        
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
        
                } else {
                    print("No Internet")
                }
    }
}
