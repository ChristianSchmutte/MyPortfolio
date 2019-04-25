//
//  PortfolioTableViewController.swift
//  MyPortfolio
//
//  Created by Christian Schmutte on 24.04.19.
//  Copyright © 2019 Christian Schmutte. All rights reserved.
//

import UIKit


class PortfolioTableViewController: UITableViewController {
    
    let controller = Portfolio.shared
    let dummyArr = [Int]()
    var stockArray: Array<Stock> {
        return controller.listStocks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Total: \(controller.getPortfolioTotal())"
        
        controller.increaseAmountOfStock(stock: stockArray[0], by: 6)
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


    @IBAction func addStockButton(_ sender: Any) {
        var stockNameTextField = UITextField()
        var stockPriceTextField = UITextField()
        let alert = UIAlertController(title: "Add Stock", message: nil, preferredStyle: .alert)
        alert.addTextField { (companyName) in
            companyName.placeholder = "Company name"
            companyName.layoutMargins.bottom = 20
            stockNameTextField = companyName
        }
        alert.addTextField { (price) in
            price.placeholder = "9999.99"
            price.keyboardType = .decimalPad
            stockPriceTextField = price
        }
        let addStockAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let stockPriceDouble = Double(stockPriceTextField.text!) else {fatalError("Could not convert textfield into number")}
            guard let stockName = stockNameTextField.text else {fatalError("BITCH, check again, no string from texfield")}
            
            self.controller.createStock(companyName: stockName, price: stockPriceDouble)
            self.tableView.reloadData()
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(addStockAction)
        alert.addAction(cancelAlert)
        
        present(alert, animated: true)
    }
    
}
