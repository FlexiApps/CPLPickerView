//
//  TestTableViewCell.swift
//  CustomList
//
//  Created by Christos Christodoulou on 12/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

import UIKit

protocol TestTableViewCellDelegate : class {
    func cellTextFieldShouldBeginEditing(testTableViewCell: TestTableViewCell)
}


class TestTableViewCell: UITableViewCell {
    
    weak var delegate: TestTableViewCellDelegate?

    @IBOutlet weak var nameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTextField.delegate = self
    }
    
}


extension TestTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.cellTextFieldShouldBeginEditing(testTableViewCell: self)
        return true
    }
    
    
}
