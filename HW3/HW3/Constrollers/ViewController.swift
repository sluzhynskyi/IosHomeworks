//
//  ViewController.swift
//
//
//  Created by Danylo Sluzhynskyi on 10.11.2020.
//
import UIKit
var ndm1 = NoteDataManager()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var noteSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register custom cells
        noteTable.register(NoteTableViewCell.nib(), forCellReuseIdentifier: NoteTableViewCell.identifier)
        noteTable.register(DisclosureIndicatorCell.nib(), forCellReuseIdentifier: DisclosureIndicatorCell.identifier)

        // Setup for TableView
        noteTable.delegate = self
        noteTable.dataSource = self

        // Setup for SearchBar
        noteSearchBar.delegate = self
        // Setting context for CoreData
        ndm1.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Get items from Core Data
        ndm1.fetchNotes()
        ndm1.filteredNotes = ndm1.dataSource
        DispatchQueue.main.async {
            self.noteTable.reloadData()
        }
    }

    // MARK: TableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ndm1.filteredNotes.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureIndicatorCell.identifier, for: indexPath) as! DisclosureIndicatorCell
            cell.textLabel?.text = "Recently Deleted"
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            let customCell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
            let n = ndm1.filteredNotes[indexPath.row - 1]
            customCell.configure(with: n.name!, date: n.creationDate!, text: n.text!, id: Int(n.noteId))
            return customCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Open the screen with note info ()
        switch indexPath.row {
        case 0:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "removed") as? RecentlyDeletedViewController else {
                return
            }
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            vc.deletionHandler = { [weak self] in
                self?.refresh()
            }
        default:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController else {
                return
            }
            vc.note = ndm1.filteredNotes[indexPath.row - 1]
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            vc.complitionHandler = { [weak self] in
                self?.refresh()
            }
            vc.deletionHandler = { [weak self] in
                self?.refresh()
            }
        }

    }
    // MARK: Deletion on swipe
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            ndm1.popNote(id: Int(ndm1.filteredNotes[indexPath.row - 1].noteId))
            refresh() // new
        }
    }
    // MARK: Move cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        ndm1.filteredNotes.swapAt(sourceIndexPath.row - 1, destinationIndexPath.row - 1)
    }
    // MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { ndm1.filteredNotes = ndm1.dataSource } else {
            if searchText.hasPrefix("#") {
                let tags = Set(searchText.split(separator: "#", omittingEmptySubsequences: true).map { String($0) })
                ndm1.filterBy(tags: tags)
            } else {
                ndm1.searchBy(name: searchText) } }
        self.noteTable.reloadData()

    }

    @IBAction func didTapAddButton() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController else {
            return
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.complitionHandler = { [weak self] in
            self?.refresh()
        }
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
    }
    @IBAction func didTapReorderButton(){
        noteTable.isEditing = !noteTable.isEditing
    }
    func refresh() {
        print("refresh")
        if noteSearchBar.text!.isEmpty { ndm1.filteredNotes = ndm1.dataSource }
        self.noteTable.reloadData()
    }
}
