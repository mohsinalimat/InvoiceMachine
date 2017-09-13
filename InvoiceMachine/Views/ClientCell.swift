//
//  ClientCell.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/13/17.
//  Copyright © 2017 njen. All rights reserved.
//
import Foundation
import Eureka

final class ClientCell: Cell<Client>, CellType {
    
    
    
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
        itemValue.text = ""
        itemName.text = "Client"
        
        
    }
    
    override func update() {
        super.update()
        
        // we do not want to show the default UITableViewCell's textLabel
        textLabel?.text = nil
        
        // get the value from our row
        guard let item = row.value else { return }
        
        itemValue.text = item.name
    }
}


final class ClientRow: Row<ClientCell>, RowType {
    
    open var presentationMode: PresentationMode<UIViewController>?
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<ClientCell>(nibName: "ClientCell")
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
