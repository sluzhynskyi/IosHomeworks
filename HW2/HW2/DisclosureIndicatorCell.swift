//
//  RecentlyDeletedTableCell.swift
//  HW2
//
//  Created by Danylo Sluzhynskyi on 13.11.2020.
//

import UIKit

class DisclosureIndicatorCell: UITableViewCell {
    static let identifier = "DisclosureIndicatorCell"
    static func nib() -> UINib {
        return UINib(nibName: "DisclosureIndicatorCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
