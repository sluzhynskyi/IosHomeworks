//
//  RecentlyDeletedTableCell.swift
//  HW2
//
//  Created by Danylo Sluzhynskyi on 13.11.2020.
//

import UIKit

class RecentlyDeletedTableCell: UITableViewCell {
    static let identifier = "RecentlyDeletedTableCell"
    static func nib() -> UINib {
        return UINib(nibName: "RecentlyDeletedTableCell", bundle: nil)
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
