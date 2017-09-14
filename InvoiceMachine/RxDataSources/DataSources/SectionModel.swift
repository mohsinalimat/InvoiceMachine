//
//  SectionModel.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/14/17.
//  Copyright © 2017 njen. All rights reserved.
//
import Foundation

public struct SectionModel<Section, ItemType>
    : SectionModelType
, CustomStringConvertible {
    public typealias Identity = Section
    public typealias Item = ItemType
    public var model: Section
    
    public var identity: Section {
        return model
    }
    
    public var items: [Item]
    
    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
    
    public var description: String {
        return "\(self.model) > \(items)"
    }
}

extension SectionModel {
    public init(original: SectionModel<Section, Item>, items: [Item]) {
        self.model = original.model
        self.items = items
    }
}
