//
//  ViewController.swift
//  
//
//  Created by Danylo Sluzhynskyi on 10.11.2020.
//
import UIKit
var ndm1 = NoteDataManager()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NoteTableViewCellDelegate{
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var noteSearchBar: UISearchBar!
    

    var filteredNotes: [Note]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTable.register(NoteTableViewCell.nib(), forCellReuseIdentifier: NoteTableViewCell.identifier)
        noteTable.delegate = self
        noteTable.dataSource = self
        noteSearchBar.delegate = self
        filteredNotes = ndm1.dataSource
        
        // Do any additional setup after loading the view.


    }


    // MARK: TableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
        let n = filteredNotes[indexPath.row]
        customCell.configure(with: n.name, date: n.creationDate, text:n.text, id:n.noteId)
        customCell.delegate = self
        return customCell
    }
    
    func didTappedButton(with noteId: Int) {
        ndm1.toggleFavorite(id: noteId)
        self.refresh()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Open the screen with note info ()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController else {
            return
        }
        vc.note = filteredNotes[indexPath.row]
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.complitionHadler = { [weak self] in
            self?.refresh()
        }
    }

    // MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotes = searchText.isEmpty ? ndm1.dataSource : {
            if searchText.hasPrefix("#"){
                let tags = Set(searchText.split(separator: "#", omittingEmptySubsequences: true).map{String($0)})
                return ndm1.filterBy(tags:tags)
            }
            return ndm1.searchBy(name: searchText)
        }()
        self.noteTable.reloadData()

    }
    
    @IBAction func didTapAddButton(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "enter") as? EntryViewController else {
            return
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.complitionHadler = { [weak self] in
            self?.refresh()
        }
    }
    func refresh(){
//        print("refreshing")
        
        filteredNotes = ndm1.dataSource
        self.noteTable.reloadData()
    }
}


