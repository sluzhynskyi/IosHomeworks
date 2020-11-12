//
//  NoteTableViewCell.swift
//  testApp
//
//  Created by Danylo Sluzhynskyi on 11.11.2020.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    static let identifier = "NoteTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "NoteTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, date:Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        nameLable.text = title
        dateLable.text = formatter.string(from: date)
    }
    
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var dateLable: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
