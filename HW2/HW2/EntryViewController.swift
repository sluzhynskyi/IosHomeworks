//
//  EntryViewController.swift
//  HW2
//
//  Created by Danylo Sluzhynskyi on 11.11.2020.
//
import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var name: UITextView!
    @IBOutlet var constraintName: NSLayoutConstraint!
    @IBOutlet var text: UITextView!
    @IBOutlet var constraintText: NSLayoutConstraint!
    public var complitionHadler: (() -> Void)?

    var note: Note?
    override func viewDidLoad() {
        super.viewDidLoad()

        name.becomeFirstResponder()
        name.delegate = self
        text.delegate = self
        if self.note != nil {
            name.text = self.note!.name
            text.text = self.note!.text
            print("not nill")
        } else {
            self.note = ndm1.createNote(name: "", text: "")
        }
        constraintName.constant = self.name.contentSize.height
        constraintText.constant = self.text.contentSize.height

//        name.text = "Do any additional setup after loading the view."
//        constraintName.constant = self.name.contentSize.height

//        text.text = "Do any additional setup after loading the view. fjdksal;fjdksa;fjdksal;fdjskalfjdksa fjkdsla;fjdsa"
//        constraintText.constant = self.text.contentSize.height
        // Do any additional setup after loading the view.
    }

    func textViewDidChange(_ textView: UITextView) {
        if (textView === name) {
            constraintName.constant = self.name.contentSize.height
            note!.name = textView.text
        } else if (textView === text) {
            constraintText.constant = self.text.contentSize.height
            note!.text = textView.text
        }
        ndm1.setNote(id: self.note!.noteId, note: self.note!)
        complitionHadler?()
    }

}
