//
//  ClientSearchResultViewModel.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/16/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class ClientViewModel {
    let searchResult: Client
    var title: Driver<String>
    
    init(searchResult: Client) {
        self.searchResult = searchResult
        
        self.title = Driver.never()
    
    }

}
