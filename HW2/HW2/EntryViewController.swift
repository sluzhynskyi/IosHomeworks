//
//  EntryViewController.swift
//  HW2
//
//  Created by Danylo Sluzhynskyi on 11.11.2020.
//
import UIKit
extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
class EntryViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var name: UITextView!
    @IBOutlet var constraintName: NSLayoutConstraint!
    @IBOutlet var text: UITextView!
    @IBOutlet var constraintText: NSLayoutConstraint!
    @IBOutlet var tags: UITextView!
    @IBOutlet var constraintTags: NSLayoutConstraint!
    public var complitionHadler: (() -> Void)?

    var note: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        text.delegate = self
        tags.delegate = self
        tags.layer.cornerRadius = 12
        if self.note != nil {
            name.text = self.note!.name
            text.text = self.note!.text
            print(self.note!.tags)
            tags.text = "#" + [String](self.note!.tags).joined(separator: " #")
            print("not nill")
        } else {
            self.note = ndm1.createNote(name: "", text: "")
            name.text = ""
            text.text = ""
            tags.text = "#"
        }
        constraintName.constant = self.name.contentSize.height
        constraintText.constant = self.text.contentSize.height
        constraintTags.constant = self.tags.contentSize.height
    }
    func textViewDidChange(_ textView: UITextView) {
        if (textView === name) {
            constraintName.constant = self.name.contentSize.height
            note!.name = textView.text
        } else if (textView === text) {
            constraintText.constant = self.text.contentSize.height
            note!.text = textView.text
        } else if (textView === tags) {
            constraintTags.constant = self.tags.contentSize.height
            if textView.text.contains("#") {
                let tagsArray = textView.text.split(separator: "#", omittingEmptySubsequences: true).map { String($0).trim() }
                note!.tags = Set(tagsArray)
            }
        }
        ndm1.setNote(id: self.note!.noteId, note: self.note!)
        complitionHadler?()
    }

}
