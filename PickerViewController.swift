//
//  PickerViewController.swift
//  CustomList
//
//  Created by Christos Christodoulou on 12/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

import UIKit

@objc

public protocol PickerViewControllerDelegate: class {
    func didCancel(pickerViewController: PickerViewController)
    func pickerViewController(pickerViewController: PickerViewController, didSelectRow row: Int, inSection section: Int, _ customText: String?)
}

public class PickerViewController: UIViewController {
    
    //MARK: Outlets & Controls
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: PickerViewControllerDelegate?
    let editableCellReuseIdentifier = "editableCellReuseIdentifier"
    let staticCellReuseIdentifier = "staticCellReuseIdentifier"

    //MARK: init
    var row : Int?
    var section: Int?
    var selectedIndexPath: IndexPath? = nil
    var pickerTitle: String = "Label"
    var textLengthAllowanceInt : Int = 40
    var staticItemsArray = [String]()
    var editableItemsArray = [String]()
    var staticImageViewArray = [String]()
    var isSearchBarFiltered: Bool = false
    var filteredItems = [String]()
    var colorForBackgroundView = UIColor.green
    var colorForSeparatorLine = UIColor.black
    var colorForCustomCell = UIColor.blue
    var colorForTextFieldWarning = UIColor.red
    var fontForCustomCell = UIFont(name: "HelveticaNeue-UltraLight", size: 20.0)

    public init(staticItems: [String], editableItems: [String], staticImageItems: [String], pickerRow: Int, pickerSection: Int) {
        //pass the preselected data
        staticItemsArray = staticItems
        editableItemsArray = editableItems
        staticImageViewArray = staticImageItems
        row = pickerRow
        section = pickerSection
        
        if let row = row,
            let section = section {
            selectedIndexPath = [row, section]
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: view lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibCells()
        
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = colorForBackgroundView
        tableView.separatorColor = colorForSeparatorLine
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        
        view.backgroundColor = colorForBackgroundView
        title = pickerTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        edgesForExtendedLayout = []
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedIndexPath == nil {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        tableView.reloadData()
    }
    
    //MARK: Register XIBs
    func registerNibCells() {
        tableView.register(UINib(nibName: "EditableTableViewCell", bundle: nil), forCellReuseIdentifier: editableCellReuseIdentifier)
        tableView.register(UINib(nibName: "StaticTableViewCell", bundle: nil), forCellReuseIdentifier: staticCellReuseIdentifier)
    }
    
    //MARK: Bar Buttons Action
    func cancelTapped() {
        delegate?.didCancel(pickerViewController: self)
    }
    
    func doneTapped() {
        if selectedIndexPath == nil{ return }
        //dismiss keyboard
        view.endEditing(true)
        
        if let indexPath = selectedIndexPath {
            let customeText = editableItemsArray.indices.contains(indexPath.row) ? editableItemsArray[indexPath.row] : ""
            delegate?.pickerViewController(pickerViewController: self, didSelectRow: indexPath.row, inSection: indexPath.section, customeText)
        }
    }
}

extension PickerViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        if editableItemsArray.count > 0 {
            return 2
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return staticItemsArray.count
        } else {
            return editableItemsArray.count
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        return 44
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: staticCellReuseIdentifier, for: indexPath) as! StaticTableViewCell
            cell.staticLabel?.text = staticItemsArray[indexPath.row]
            cell.staticLabel.font = fontForCustomCell
            if !staticImageViewArray.isEmpty {
                cell.staticImage.image = UIImage(named: staticImageViewArray[indexPath.row])
                cell.staticImage.layer.borderColor = colorForCustomCell.cgColor
                cell.staticImage.layer.borderWidth = 1.0
            }
            else {
                cell.staticImage.isHidden = true
            }
            cell.tintColor = colorForCustomCell
            cell.accessoryType = selectedIndexPath == indexPath ? .checkmark : .none
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: editableCellReuseIdentifier, for: indexPath) as! EditableTableViewCell
            cell.textField?.text = editableItemsArray[indexPath.row]
            cell.textField.font = fontForCustomCell
            cell.tintColor = colorForCustomCell
            cell.textField.placeholder = NSLocalizedString("add_custom_label", comment: "")
            cell.delegate = self
            cell.selectionStyle = .none
            cell.accessoryType = selectedIndexPath == indexPath ? .checkmark : .none
            return cell
        }
    }
}

extension PickerViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            if selectedIndexPath == indexPath {
                selectedIndexPath = nil
                navigationItem.rightBarButtonItem?.isEnabled = selectedIndexPath == indexPath ? true : false
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                let previouslySelectedIndexPath = selectedIndexPath
                selectedIndexPath = indexPath
                navigationItem.rightBarButtonItem?.isEnabled = selectedIndexPath == indexPath ? true : false
                if previouslySelectedIndexPath != nil {
                    tableView.reloadRows(at: [previouslySelectedIndexPath!, selectedIndexPath!], with: .automatic)
                } else {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
}

extension PickerViewController: EditableTableViewCellDelegate {
    
    func cellTextFieldDidBeginEditing(_ cell: EditableTableViewCell) {
        if ((editableItemsArray.first?.characters.count)! > textLengthAllowanceInt || (editableItemsArray.first?.characters.count)! == 0) {
            navigationItem.rightBarButtonItem?.isEnabled = false
            cell.textField.textColor = colorForTextFieldWarning
        }
        if let activeIndexPath = tableView.indexPath(for: cell) {
            //- Start editing the one already selected
            if activeIndexPath == selectedIndexPath {
                selectedIndexPath = nil
                tableView.reloadRows(at: [activeIndexPath], with: .automatic)
            } else { //- This cell was not previously selected
                let previouslySelectedIndexPath = selectedIndexPath
                selectedIndexPath = activeIndexPath
                if previouslySelectedIndexPath != nil { //- A cell was selected before
                    tableView.cellForRow(at: previouslySelectedIndexPath!)?.accessoryType = .none
                } else { //- No Cell was selected before
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        }
    }
    
    func cellShouldChangeCharactersIn(_ cell: EditableTableViewCell, _ range: NSRange, _ string: String) {
        let resultedLength: Int = (cell.textField.text?.characters.count)! + (string.characters.count) - range.length
        if resultedLength > textLengthAllowanceInt {
            cell.textField.textColor = colorForTextFieldWarning
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            cell.textField.textColor = .black
            navigationItem.rightBarButtonItem?.isEnabled = resultedLength == 0 ? false : true
        }
    }
    
    func cellTextFieldShouldClear(_ cell: EditableTableViewCell) {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func cellTextFieldDidEndEditing(_ cell: EditableTableViewCell) {
        if
            let activeIndexPath = tableView.indexPath(for: cell),
            let text = cell.textField.text {
            editableItemsArray[activeIndexPath.row] = text
        }
    }
    
}
