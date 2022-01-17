//
//  ViewController.swift
//  challenge-2
//
//  Created by Bruno Guirra on 17/01/22.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingListItens = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListItens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = shoppingListItens[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}

