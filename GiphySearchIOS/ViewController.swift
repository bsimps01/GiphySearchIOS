//
//  ViewController.swift
//  GiphySearchIOS
//
//  Created by Benjamin Simpson on 4/6/20.
//  Copyright © 2020 Benjamin Simpson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var network = GifNetwork()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            setup()
        }
        /// Setup tableview delegates.
        func setup() {
            tableView.delegate = self
            tableView.dataSource = self
            // Search bar
            searchBar.searchTextField.delegate = self
            searchBar.searchTextField.placeholder = "Whats your favorite gif?"
            searchBar.returnKeyType = .search
        }
    
    /**
    Fetches gifs based on the search term and populates tableview
    - Parameter searchTerm: The string to search gifs of
    */
    func fetchGifs(for searchText: String) {
        network.fetchGifs(searchTerm: searchText) { results in
            if results != nil {
                print(results!.giphs.count)
                self.giphs = results!.giphs
                self.tableView.reloadData()
            }
        }
    }

}

// MARK: - Tableview functions
extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchTextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gifCell") as! GifCell
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            fetchGifs(for: textField.text!)
        }
        return true
    }
}

