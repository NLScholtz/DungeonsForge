//
//  LibraryViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class LibraryViewController: NotificationViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    private lazy var viewModel = LibraryViewModel(delegate: self)
    private var expandableContentModels : [ExpandableCellContent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.layer.cornerRadius = 10
        
        self.expandableContentModels = viewModel.libraryList.map({
            return ExpandableCellContent(libraryTitle: $0.libraryTitle, libraryDescription: $0.libraryDescription)
        })
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            return
        }
        let searchText = textField.text
        print(searchText ?? "")
        viewModel.librarySearched(searchString: searchText ?? "")
    }
}

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandableContentModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as! LibraryTableViewCell
        let expandableCellContent = expandableContentModels?[indexPath.row] ?? ExpandableCellContent()
        cell.set(title: expandableCellContent.libraryTitle ?? "", describtion: expandableCellContent.libraryDescription ?? "", isExpanded: expandableCellContent.isExpanded ?? false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let expandableCellContent = expandableContentModels?[indexPath.row] ?? ExpandableCellContent()
        expandableCellContent.isExpanded = !expandableCellContent.isExpanded!
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension LibraryViewController: LibraryViewModelDelegate {
    func updateFilteredSearch() {
        self.expandableContentModels = viewModel.searchedLibrary.map({
            return ExpandableCellContent(libraryTitle: $0.libraryTitle, libraryDescription: $0.libraryDescription)
        })
        tableView.reloadData()
    }
}

extension LibraryViewController: UITextViewDelegate, UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

