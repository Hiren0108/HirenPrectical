//
//  AllCityCell.swift
//  HirenPrectical
//
//  Created by IOSDEV1 on 20/08/21.
//

import UIKit

class AllCityCell: UITableViewCell {
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    static var identifier : String {
        return String(describing: self)
        
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    func setData(obj: AllCityModel) {
        lblFirstName.text = obj.first_name
        lblLastName.text = obj.last_name
        lblCity.text = obj.city
    }
}
