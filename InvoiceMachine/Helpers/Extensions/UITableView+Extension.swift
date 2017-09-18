//
//  UITableView+Extension.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/16/17.
//  Copyright © 2017 njen. All rights reserved.
//

import UIKit

extension UITableView {
    
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}

