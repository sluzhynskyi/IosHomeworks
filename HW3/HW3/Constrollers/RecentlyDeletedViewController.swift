//
//  RecentlyDeletedViewController.swift
//  HW3
//
//  Created by Danylo Sluzhynskyi on 13.11.2020.
//

import UIKit

class RecentlyDeletedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DeleteOrRestoreTableViewCellDelegate {
    public var deletionHandler: (() -> Void)?
    func didTapRecoverNote(with noteId: Int) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let recoverNote = UIAlertAction(title: "Recover Note", style: .default, handler: { (action) in
            ndm1.restoreNote(id: noteId)
            self.deletionHandler?()
            self.recentlyDeletedTable.reloadData()
        })
        alert.addAction(recoverNote)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }

    func didTapDeleteNote(with noteId: Int) {
        let alert = UIAlertController(title: nil, message: "This note will be deleted. This action cannot be undone.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteNote = UIAlertAction(title: "Delete Note", style: .destructive, handler: { (action) in
            if let index = ndm1.removedSource.firstIndex(where: { $0.noteId == noteId }) {
                ndm1.removedSource.remove(at: index)
            }
            self.recentlyDeletedTable.reloadData()
        })
        alert.addAction(cancel)
        alert.addAction(deleteNote)
        present(alert, animated: true, completion: nil)

    }

    @IBOutlet weak var recentlyDeletedTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recentlyDeletedTable.delegate = self
        recentlyDeletedTable.dataSource = self
        recentlyDeletedTable.register(DeleteOrRestoreTableViewCell.nib(), forCellReuseIdentifier: DeleteOrRestoreTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ndm1.removedSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeleteOrRestoreTableViewCell.identifier, for: indexPath) as! DeleteOrRestoreTableViewCell
        let note = ndm1.removedSource[indexPath.row]
        cell.configure(with: note.name!, id: Int(note.noteId))
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
