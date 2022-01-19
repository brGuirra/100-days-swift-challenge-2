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
        let ac = UIAlertController(title: "Clear list", message: nil, preferredStyle: .alert)
        
        let clearAction = UIAlertAction(title: "Clear", style: .default) {
            [weak self] _ in
            
            if let shoppingListItens = self?.shoppingListItens {
                if shoppingListItens.isEmpty {
                    self?.showErrorMessage(title: "Can't clear", message: "The list is already empty")
                    return
                }
                
                self?.shoppingListItens.removeAll(keepingCapacity: true)
                self?.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        ac.addAction(clearAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    @objc func shareList() {
        if shoppingListItens.isEmpty {
            showErrorMessage(title: "Empty list", message: "Can't share an empty list, please insert some items")
            
            return
        }
        
        let list = shoppingListItens.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
    func promptForListItem() {
        let ac = UIAlertController(title: "Add an item", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            
            guard let listItem = ac?.textFields?[0].text?.lowercased() else { return }
            
            if listItem.isEmpty {
                self?.showErrorMessage(title: "Can't add", message: "You have to type something to add in the list")
                return
            }
            
            if let shoppingListItens = self?.shoppingListItens {
                if shoppingListItens.contains(listItem) {
                    self?.showErrorMessage(title: "Can't add", message: "The item already exists in your list")
                    return
                }
            }
            
            self?.shoppingListItens.insert(listItem, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    func addItem() -> UIAction {
        return UIAction() {
            [weak self] _ in
            
            self?.promptForListItem()
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

