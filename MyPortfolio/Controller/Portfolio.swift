//
//  MainController.swift
//  MyPortfolio
//
//  Created by Christian Schmutte on 24.04.19.
//  Copyright © 2019 Christian Schmutte. All rights reserved.
//

import Foundation
import RealmSwift

class Portfolio {
    private let realm = try! Realm()
    private var stocks: Results<Stock>?
    private var portfolioTotal: Double {
        var subTotal: Double = 0.0
        for stock in stocks! {
            subTotal += Double(stock.amount) * stock.price
        }
        return subTotal
    }
    
    private func loadStocks() {
        stocks = realm.objects(Stock.self)
    }
    
    static let shared = Portfolio()
    
    private init () {
        self.loadStocks()
    }
    
    func createStock(companyName: String, price: Double, amount: Int = 1) {
        let newStock = Stock()
        newStock.name = companyName
        newStock.price = price
        newStock.amount = amount

        addStockToRealm(stock: newStock)
    }
    
    private func addStockToRealm(stock: Stock) {
    
        do {
            try realm.write {
                realm.add(stock)
                print("\(stock.amount) x \(stock.name) added to portfolio")
            }
        } catch {
            print("Error saving stock, ", error)
        }
    }
    
    func listStocks() -> [Stock] {
        
        let stockArray = Array(stocks!)
        
        return stockArray
    }
    
    func getPortfolioTotal() -> Double {
        return portfolioTotal
    }
    
    func increaseAmountOfStock(stock: Stock, by newAmount: Int) {
        
        do {
            try realm.write {
                stock.amount = newAmount
                print("\(stock.name) increased by \(newAmount)")
                
            }
        } catch {
            print("Error saving changes to stock, ", error)
        }
    }
    
}

