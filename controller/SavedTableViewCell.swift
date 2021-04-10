//
//  SavedTableViewCell.swift
//  food
//
//  Created by Raghava on 10/04/21.
//  Copyright © 2021 Raghava. All rights reserved.
//

import UIKit

class SavedTableViewCell: UITableViewCell {
    @IBOutlet weak var foodNames: UILabel!
    @IBOutlet weak var foodInstr: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
