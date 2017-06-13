//
//  TestViewController.swift
//  CustomList
//
//  Created by Christos Christodoulou on 12/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

import UIKit

@objc

protocol TestViewControllerDelegate {
    func didCancel(testViewController: TestViewController)
    
    func didSelectItem(selectedStaticItemIndex: Int)
    
    func didSelectEditableItem(selectedEditableItemIndex: Int, customEditableItem: String)
    
    func didSelectNothing(testViewController: TestViewController)
}

class TestViewController: UIViewController {
    
    //MARK: Outlets & Controls
    @IBOutlet weak var tableView: UITableView!
    

    
    let MAX_TEXTFIELD_ALLOWANCE = 10

    weak var delegate: TestViewControllerDelegate?

    //MARK: init
    var selectedStaticItemIndex : Int?
    var selectedEditableItemIndex : Int?
    var staticItemsArray = [String]()
    var editableItemsArray = [String]()
    
    init(staticItems: [String], editableItems: [String], staticItemIndex: Int, editableItemIndex: Int) {
        //pass the preselected data
        staticItemsArray = staticItems
        editableItemsArray = editableItems
        selectedStaticItemIndex = staticItemIndex == -1 ? nil : staticItemIndex
        selectedEditableItemIndex = editableItemIndex == -1 ? nil : editableItemIndex
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "test")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .lightGray

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    }
    
    //MARK: Bar Buttons Action
    func cancelTapped() {
        delegate?.didCancel(testViewController: self)
    }
    
    func doneTapped() {
        
        if let staticIndex = selectedStaticItemIndex {
            delegate?.didSelectItem(selectedStaticItemIndex: staticIndex)
        }

        if let editableIndex = selectedEditableItemIndex {
            delegate?.didSelectEditableItem(selectedEditableItemIndex: editableIndex, customEditableItem: "test")
        }
            
        if selectedStaticItemIndex == nil && selectedEditableItemIndex == nil {
            delegate?.didSelectNothing(testViewController: self)
        }


    }
}

extension TestViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return staticItemsArray.count
        } else {
            return editableItemsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! TestTableViewCell
        
        if (indexPath.section == 0) {
            cell.nameTextField.isEnabled = false
            if (selectedStaticItemIndex == indexPath.row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.nameTextField?.text = staticItemsArray[indexPath.row]
        } else {
            
            cell.delegate = self
            cell.selectionStyle = .none
            
            if (selectedEditableItemIndex == indexPath.row) {
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }

            cell.nameTextField?.text = editableItemsArray[indexPath.row]

        }

        return cell
    }

}

extension TestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 0) {
            if selectedStaticItemIndex == indexPath.row {
                selectedStaticItemIndex = nil
            } else {
                selectedEditableItemIndex = nil
                selectedStaticItemIndex = indexPath.row
            }
            tableView.reloadData()
        }

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
}

extension TestViewController: TestTableViewCellDelegate {
    func cellTextFieldShouldBeginEditing(testTableViewCell: TestTableViewCell) {
        print("selected")
        if let indexPath = tableView.indexPath(for: testTableViewCell) {
            if selectedEditableItemIndex == indexPath.row {
                selectedEditableItemIndex = nil
            } else {
                selectedStaticItemIndex = nil
                selectedEditableItemIndex = indexPath.row
            }
            tableView.reloadData()
        }

    }
}

