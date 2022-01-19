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
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]        
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        let addButton = createButton()
        
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 80),
            addButton.heightAnchor.constraint(equalToConstant: 80),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
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
    
    
    @objc func clearList() {
        
    }
    
    @objc func shareList() {

    }
    
    func addItem() -> UIAction {
        return UIAction() { _ in
        }
    }
    
    func createButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 160, y: 160, width: 80, height: 80)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.setImage(UIImage(systemName: "plus.circle.fill") , for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addAction(addItem(), for: .touchUpInside)
        return button
    }
}

