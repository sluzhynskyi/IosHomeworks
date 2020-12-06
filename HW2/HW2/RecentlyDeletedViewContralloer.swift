//
//  RecentlyDeletedViewController.swift
//  HW2
//
//  Created by Danylo Sluzhynskyi on 13.11.2020.
//

import UIKit

class RecentlyDeletedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recentlyDeletedTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recentlyDeletedTable.delegate = self
        recentlyDeletedTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
