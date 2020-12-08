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
    var noteId: Int = 0
    public func configure(with title: String, date: Date, text: String, id : Int) {
        self.noteId = id
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        nameLable.text = title
        dateLable.text = formatter.string(from: date)
        textLable.text = text
        
    }

    @IBOutlet var nameLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var textLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
