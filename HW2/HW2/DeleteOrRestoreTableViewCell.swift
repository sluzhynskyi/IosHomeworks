//
//  DeleteOrRestoreTableViewCell.swift
//  HW2
//
//  Created by Danylo Sluzhynskyi on 13.11.2020.
//

import UIKit
protocol DeleteOrRestoreTableViewCellDelegate {
    func didTapRecoverNote(with noteId:Int)
    func didTapDeleteNote(with noteId:Int)
}
class DeleteOrRestoreTableViewCell: UITableViewCell {
    static let identifier = "DeleteOrRestoreTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DeleteOrRestoreTableViewCell", bundle: nil)
    }
    @IBOutlet var nameLable: UILabel!
    var noteId:Int = 0
    var delegate:DeleteOrRestoreTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(with title: String, id nodeId:Int) {
        nameLable.text = title
        self.noteId = nodeId
    }
    @IBAction func recoverNote(_ sender: UIButton) {
        delegate!.didTapRecoverNote(with: self.noteId)
        
    }
    @IBAction func deleteNote(_ sender: UIButton) {
        delegate!.didTapDeleteNote(with:self.noteId)
        
    }
    
}

