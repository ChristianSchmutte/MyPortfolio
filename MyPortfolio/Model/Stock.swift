//
//  Stock.swift
//  MyPortfolio
//
//  Created by Christian Schmutte on 24.04.19.
//  Copyright © 2019 Christian Schmutte. All rights reserved.
//

import Foundation
import RealmSwift

class Stock : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var amount: Int = 0
    
    var total : Double {
        return price * Double(amount)
    }
    
    
}

