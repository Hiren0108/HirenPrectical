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

    //MARK:- Outlets
    @IBOutlet weak var tblAllCity: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- Variable
    var responseAllCity : [AllCityModel] = [AllCityModel]()
    var searching = false
    var filterdata:[String] = [String]()
    
    //MARK:- View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK:- SetupUI
    func setupUI() {
        searchBar.delegate = self
        tblAllCity.delegate = self
        tblAllCity.dataSource = self
        tblAllCity.register(AllCityCell.nib, forCellReuseIdentifier: AllCityCell.identifier)
        apiCalling()
    }

}

//MARK:- Tableview Delegate Datasource
extension AllCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
             return filterdata.count
        }else{
            return responseAllCity.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCityCell.identifier, for: indexPath) as! AllCityCell
        let obj = responseAllCity[indexPath.row]
        //let searchObj = filterdata[indexPath.row]
        cell.setData(obj: obj)
//        if searching {
//            cell.setData(obj: searchObj)
//        }else{
//            cell.setData(obj: obj)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

//MARK:- API Calling
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

extension AllCityVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //self.filterdata = searchText.isEmpty ? responseAllCity : responseAllCity.filter { $0.city(searchText) }
            
            
            
            
            //countryList.filter({ $0.prefix(searchText.count) == searchText })
        self.searching = true
        tblAllCity.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searching = false
        searchBar.text = ""
        tblAllCity.reloadData()
    }
}
