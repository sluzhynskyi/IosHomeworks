//
//  ViewController.swift
//  
//
//  Created by Danylo Sluzhynskyi on 10.11.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var noteSearchBar: UISearchBar!
    var ndm1 = NoteDataManager()
    var filteredNotes: [Note]!
    override func viewDidLoad() {
        super.viewDidLoad()

        ndm1.createNote(name: "Fav Books",
            text: "Lord of the Rings, Harry Potter and the Goblet of Fire",
            tags: ["books", "fantasy", "popular",])
        ndm1.createNote(name: "Mafia strategy",
            text: "Not nervous, play with outher players, find mafia, ...",
            tags: ["remember", "popular", "game"])
        ndm1.createNote(name: "Dogs breeds",
            text: "Labrador Retrievers, German Shepherds, Golden Retrievers, Beagles, German Shorthaired Pointers",
            tags: ["remember", "popular", "dogs"])
        ndm1.createNote(name: "Stocks portfolio",
            text: "S&P 500, AAPL, AMZN, MSFT, GOOG",
            tags: ["money", "stocks",])
        ndm1.createNote(name: "Plan for a day",
            text: "do hw, to  meet with girl, to kiss with girl, ... ",
            tags: ["plans", "remember", "personal"])
        ndm1.createNote(name: "Fav boardgame",
            text: "secret hitler, classic mafia, DND, Spy ",
            tags: ["popular", "game"])
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
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

    // MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotes = searchText.isEmpty ? ndm1.dataSource : ndm1.searchBy(name: searchText)
        self.noteTable.reloadData()

    }
}

