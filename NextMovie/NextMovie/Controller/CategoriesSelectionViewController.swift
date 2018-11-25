//
//  CategoriesSelectionViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 16/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class CategoriesSelectionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoriesNotFoundView: CategoriesNotFoundView!
    
    // MARK: - Properties
    public weak var categoryDelegate: CategoryDelegate?
    public var selectedCategories: [Category] = []
    private var categories: [Category] = []
    private var isDarkModeEnabled: Bool!
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.retrieveCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        self.setupViewMode(darkMode: self.isDarkModeEnabled)
    }
    
    override func setupViewMode(darkMode: Bool) {
        
        super.setupViewMode(darkMode: darkMode)
        self.view.backgroundColor = darkMode ? .black : .white
        
    }
    
    // MARK: - Methods
    
    private func retrieveCategories() {
        
        if let categories = CategoryServices.list() {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.categoryDelegate?.select(categories: self.selectedCategories)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: Localization.category, message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: Localization.save, style: .default) { (_) in
            let categoryName = alert.textFields?.first?.text
            
            let category = Category()
            category.name = categoryName
            CategoryServices.save(category: category)
            
            self.retrieveCategories()
        }
        let cancelButton = UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelButton)
        
        alert.addTextField { (textField) in
            textField.placeholder = Localization.nameOfCategory
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CategoriesSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let categoriesCount = self.categories.count
        self.tableView.backgroundView = (categoriesCount <= 0) ? self.categoriesNotFoundView : nil
        
        return categoriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentCategory = self.categories[indexPath.row]
        
        if selectedCategories.contains(currentCategory) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        cell.textLabel?.text = currentCategory.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.textLabel?.textColor = self.isDarkModeEnabled ? .white : .black
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let category = self.categories.remove(at: indexPath.row)
            CategoryServices.delete(category: category)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension CategoriesSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCategory = self.categories[indexPath.row]
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            self.selectedCategories.removeAll(where: { $0 == selectedCategory })
        } else {
            cell.accessoryType = .checkmark
            self.selectedCategories.append(selectedCategory)
        }
    }
}
