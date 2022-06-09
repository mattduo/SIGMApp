//
//  EventCellTableViewCell.swift
//  SIGMA
//
//  Created by Matt on 18/5/2022.
//

import UIKit

class EventCellTableViewCell: UITableViewCell {
    @IBOutlet weak var eventLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
