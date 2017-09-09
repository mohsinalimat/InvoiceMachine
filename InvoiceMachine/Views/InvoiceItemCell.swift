//
//  InvoiceItemCell.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/9/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation
import Eureka

final class InvoiceItemCell: Cell<InvoiceItem>, CellType {
    

    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemValue: UILabel!
    
    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setup() {
        super.setup()
        // we do not want our cell to be selected in this case. If you use such a cell in a list then you might want to change this.
        selectionStyle = .none
        
    
        
        // define fonts for our labels
        
        itemValue.font = .systemFont(ofSize: 18)
        itemName.font = .systemFont(ofSize: 13.3)
        itemName.font = .systemFont(ofSize: 13.3)
        
        // set the textColor for our labels
        for label in [itemName ] {
            label?.textColor = .gray
        }
                
        // set a light background color for our cell
        backgroundColor = UIColor(red:0.984, green:0.988, blue:0.976, alpha:1.00)
    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil
        
        // get the value from our row
        guard let item = row.value else { return }
        
        itemValue.text = "$\(item.amount) \u{0009}"
        itemName.text = item.description
    }
}


final class InvoiceItemRow: Row<InvoiceItemCell>, RowType {
    
    open var presentationMode: PresentationMode<UIViewController>?
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<InvoiceItemCell>(nibName: "InvoiceItem")
    }
    
    open override func customDidSelect() {
        super.customDidSelect()
        if !isDisabled {
            if let presentationMode = presentationMode {
                if let controller = presentationMode.makeController() {
                    presentationMode.present(controller, row: self, presentingController: self.cell.formViewController()!)
                } else {
                    presentationMode.present(nil, row: self, presentingController: self.cell.formViewController()!)
                }
            }
        }
    }
    
    open override func customUpdateCell() {
        super.customUpdateCell()
        let leftAligmnment = presentationMode != nil
        cell.textLabel?.textAlignment = leftAligmnment ? .left : .center
        cell.accessoryType = !leftAligmnment || isDisabled ? .none : .disclosureIndicator
        cell.editingAccessoryType = cell.accessoryType
        cell.textLabel?.textColor = !leftAligmnment ? cell.tintColor.withAlphaComponent(isDisabled ? 0.3 : 1.0) : nil
    }
    
    open override func prepare(for segue: UIStoryboardSegue) {
        super.prepare(for: segue)
        (segue.destination as? RowControllerType)?.onDismissCallback = presentationMode?.onDismissCallback
    }
}
