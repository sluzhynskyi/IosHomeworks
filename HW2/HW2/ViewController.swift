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
        customCell.configure(with: n.name, date: n.creationDate)
        return customCell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
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
        filteredNotes = searchText.isEmpty ? ndm1.dataSource : ndm1.searchBy(name: searchText)
        self.noteTable.reloadData()

    }
    
    @IBAction func didTapAddutton(){
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
        print("refreshing")
        filteredNotes = ndm1.dataSource
        self.noteTable.reloadData()
    }
}


