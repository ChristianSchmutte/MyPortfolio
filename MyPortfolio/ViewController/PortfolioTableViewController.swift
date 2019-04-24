//
//  PortfolioTableViewController.swift
//  MyPortfolio
//
//  Created by Christian Schmutte on 24.04.19.
//  Copyright © 2019 Christian Schmutte. All rights reserved.
//

import UIKit
import RealmSwift

class PortfolioTableViewController: UITableViewController {
    
    let controller = Portfolio.shared
    let dummyArr = [Int]()
    var stockArray: Array<Stock> {
        return controller.listStocks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.increaseAmountOfStock(stock: stockArray[0], by: 5)
//        print(controller.getPortfolioTotal())
//        print(Realm.Configuration.defaultConfiguration.fileURL)
    }

    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stockArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stockArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell")
        cell?.textLabel?.text = "\(stock.name): \(stock.amount) x"
        cell?.detailTextLabel?.text = "\(stock.total.rounded())"

        return cell!
    }



}
