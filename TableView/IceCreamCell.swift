//
//  IceCreamCell.swift
//  TableView
//
//  Created by Ника Перепелкина on 20/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class IceCreamCell: UITableViewCell {

    
    @IBOutlet weak var iceCreamImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredienceLabel: UILabel!
   // @IBOutlet weak var adressLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
