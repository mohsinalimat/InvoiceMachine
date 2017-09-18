//
//  ClientSearchCell.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/16/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

public class ClientSearchCell: UITableViewCell {
    
    var disposeBag: DisposeBag?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var viewModel: Client? {
        didSet {
            
            guard let viewModel = viewModel else {
                return
            }
            self.textLabel?.text = viewModel.name
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.disposeBag = nil
    }
    
    deinit {
    }
    
}

fileprivate protocol ReusableView: class {
    var disposeBag: DisposeBag? { get }
    func prepareForReuse()
}

extension ClientSearchCell : ReusableView {
    
}
