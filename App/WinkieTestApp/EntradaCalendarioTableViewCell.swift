//
//  EntradaCalendarioTableViewCell.swift
//  Winkie
//
//  Created by Tomas Martins on 12/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class EntradaCalendarioTableViewCell: UITableViewCell {
    @IBOutlet weak var eventTitleTextField: UITextField!
    
    @IBOutlet weak var eventLocationTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
