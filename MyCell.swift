//
//  MyCell.swift
//  Test Application
//
//  Created by Kiril on 06.05.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    //Класс нашей кастомной ячейки
    
    @IBOutlet weak var imRestaurants: UIImageView!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var lLocation: UILabel!
    @IBOutlet weak var lType: UILabel!
    @IBOutlet weak var bDouble: UIButton!
    @IBOutlet weak var bDellCell: UIButton!
 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
