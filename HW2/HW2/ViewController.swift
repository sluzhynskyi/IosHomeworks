//
//  ViewController.swift
//
//
//  Created by Danylo Sluzhynskyi on 10.11.2020.
//
import UIKit
var ndm1 = NoteDataManager()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NoteTableViewCellDelegate {
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var noteSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        noteTable.register(NoteTableViewCell.nib(), forCellReuseIdentifier: NoteTableViewCell.identifier)
        noteTable.register(DisclosureIndicatorCell.nib(), forCellReuseIdentifier: DisclosureIndicatorCell.identifier)
        noteTable.delegate = self
        noteTable.dataSource = self
        noteSearchBar.delegate = self
        ndm1.filteredNotes = ndm1.dataSource
        // Do any additional setup after loading the view.


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
            customCell.configure(with: n.name, date: n.creationDate, text: n.text, id: n.noteId)
            customCell.delegate = self
            return customCell
        }
    }

    func didTappedButton(with noteId: Int) {
        ndm1.toggleFavorite(id: noteId)
        self.noteTable.reloadData()
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

    // MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        if searchText.hasPrefix("#") {
                let tags = Set(searchText.split(separator: "#", omittingEmptySubsequences: true).map { String($0) })
                ndm1.filterBy(tags: tags)
            } else {
                ndm1.searchBy(name: searchText)}
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
    func refresh() {
        print("refresh")
        ndm1.filteredNotes = ndm1.dataSource
        self.noteTable.reloadData()
    }
}


