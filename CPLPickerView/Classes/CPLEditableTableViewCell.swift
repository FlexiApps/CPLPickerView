//
//  CPLEditableTableViewCell.swift
//  CustomList
//
//  Created by Christos Christodoulou on 12/06/2017.
//  Copyright © 2017 Christos Christodoulou. All rights reserved.
//

import UIKit

@objc
protocol EditableTableViewCellDelegate : class {
    
    func cellTextFieldDidBeginEditing(_ cell: CPLEditableTableViewCell)
    func cellShouldChangeCharactersIn(_ cell: CPLEditableTableViewCell, _ range: NSRange, _ string: String )
    func cellTextFieldShouldClear(_ cell: CPLEditableTableViewCell)
    func cellTextFieldDidEndEditing(_ cell: CPLEditableTableViewCell)
}

@objc
class CPLEditableTableViewCell: UITableViewCell {
    
    weak var delegate: EditableTableViewCellDelegate?

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textField.delegate = self
    }

}

extension CPLEditableTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.cellTextFieldDidBeginEditing(self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.cellShouldChangeCharactersIn(self, range, string)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.cellTextFieldShouldClear(self)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.cellTextFieldDidEndEditing(self)
    }
    

}
