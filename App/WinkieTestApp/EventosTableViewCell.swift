//
//  EventosTableViewCell.swift
//  Winkie
//
//  Created by student on 12/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class EventosTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventStart: UILabel!
    @IBOutlet weak var eventFinish: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
