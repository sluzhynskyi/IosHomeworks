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
        ndm1.restoreNote(id: noteId)
        deletionHandler?()
        recentlyDeletedTable.reloadData()
    }

    func didTapDeleteNote(with noteId: Int) {
        if let index = ndm1.removedSource.firstIndex(where: {$0.noteId == noteId}) {
            ndm1.removedSource.remove(at: index)
        }
        recentlyDeletedTable.reloadData()
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
        cell.configure(with: note.name, id: note.noteId)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
