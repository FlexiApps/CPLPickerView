//
//  ViewController.swift
//  CPLPickerView
//
//  Created by christos christodoulou on 07/11/2017.
//  Copyright (c) 2017 christos christodoulou. All rights reserved.
//

import UIKit
import CPLPickerView

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    //MARK: CPL pickerView
    var pickerController: CPLPickerViewController?
    var pickerIndexPath: IndexPath? = nil
    var row : Int?
    var section : Int?
    var staticPickerData = [String]()
    var editablePickerData = [String]()
    var staticImage = [String]()
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPlacePickerData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: init picker data
    func setupPlacePickerData() {
        label.text = ""
        staticPickerData = [NSLocalizedString("1", comment: ""), NSLocalizedString("2", comment: ""), NSLocalizedString("3", comment: ""), NSLocalizedString("4", comment: ""), NSLocalizedString("5", comment: "")]
        
        if let label = label {
            if staticPickerData.contains(label.text!) {
                editablePickerData = [""]
                row = staticPickerData.index(of: label.text!)
                section = 0
                if let row = row,
                    let section = section {
                    pickerIndexPath = IndexPath(row: row, section: section)
                }
            }
            else if ((label.text?.characters.count)! > 1) && !self.staticPickerData.contains(label.text!) {
                editablePickerData = [label.text!]
                row = 0
                section = 1
                if let row = row,
                    let section = section {
                    pickerIndexPath = IndexPath(row: row, section: section)
                }
            }
            else {
                editablePickerData = [""]
                pickerIndexPath = nil
                row = -1
                section = -1
            }
        }
        pickerController = CPLPickerViewController(staticItems: staticPickerData, editableItems: editablePickerData, staticImageItems: staticImage, pickerRow: row!, pickerSection: section!)
    }
    
    @IBAction func showPickerTapped(_ sender: Any) {
        pickerController?.delegate = self
        pickerController?.pickerTitle = NSLocalizedString("choose", comment: "")
        pickerController?.textLengthAllowanceInt = 5
        pickerController?.selectedIndexPath = pickerIndexPath
        pickerController?.colorForBackgroundView = .lightGray
        pickerController?.colorForSeparatorLine = .black
        pickerController?.colorForCustomCell = .purple
        pickerController?.colorForTextFieldWarning = .orange
        let navigationController = UINavigationController(rootViewController: pickerController!)
        present(navigationController, animated: true, completion: nil)
    }
}

extension ViewController : PickerViewControllerDelegate {
    public func didCancel(pickerViewController: CPLPickerViewController) {
        pickerViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func pickerViewController(pickerViewController: CPLPickerViewController, didSelectRow row: Int, inSection section: Int, _ customText: String?) {
        pickerViewController.dismiss(animated: true, completion: nil)
        pickerIndexPath = [section, row]
        self.row = Int(row)
        self.section = Int(section)
        
        if customText == nil || customText == "" {
            editablePickerData = [""]
            label.text = staticPickerData[(pickerIndexPath?.row)!]

        }
        else {
            editablePickerData = [customText!]
            label.text = customText

        }
        
        pickerController = CPLPickerViewController(staticItems: staticPickerData, editableItems: editablePickerData, staticImageItems: staticImage, pickerRow: row, pickerSection: section)
    }
    
}

