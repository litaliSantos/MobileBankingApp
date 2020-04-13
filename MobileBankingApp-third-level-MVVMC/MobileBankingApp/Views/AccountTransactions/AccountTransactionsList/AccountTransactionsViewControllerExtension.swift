//
//  AccountTransactionsViewControllerExtension.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AccountTransactionsViewController tableView getters
extension TransactionsViewModel {
    func getAccountTransactionsListSectionTitle(section: Int) -> String? {
        if noResults {
            return nil
        } else {
            guard let sectionMonth = transactionsByMonthFiltered[section].first?.mes_lancamento else { return "" }
            return getMonthName(month: sectionMonth)
        }
    }
    
    func getNumberOfSections() -> Int {
        return noResults ? 1 : transactionsByMonthFiltered.count
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        return noResults ? 1 : transactionsByMonthFiltered[section].count
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath, searchTextFieldIsFirstResponder: Bool) -> UITableViewCell {
        if noResults {
            let noResultsCell = getPlaceholderCell(tableView: tableView, allowsInteraction: !searchTextFieldIsFirstResponder, isHeighDefinided: searchTextFieldIsFirstResponder)
            return noResultsCell
        } else {
            let transaction = transactionsByMonthFiltered[indexPath.section][indexPath.row]
            let cell = getTransactionsCell(tableView: tableView, transaction: transaction, showArrow: true)
            return cell
        }
    }
    
    // MARK: - Search
    func searchFor(transaction origin: String, success: @escaping()->()) {
        if origin == "" {
            self.transactionsByMonthFiltered = transactionsByMonth
        } else {
            self.transactionsByMonthFiltered.removeAll()
            self.transactionsByMonth.forEach({
                transactionsByMonthFiltered.append($0.filter({
                    $0.origem?.localizedCaseInsensitiveContains(origin) == true
                }))
            })
        }
        updateResults()
        success()
    }
    
    func transactionList(shouldReset: Bool) {
        if shouldReset {
            transactionsByMonthFiltered = transactionsByMonth
            updateResults()
        }
    }
    
    func updateResults() {
        var resultsList: [Transaction] = []
        transactionsByMonthFiltered.forEach({ item in
            item.forEach({ subItem in
                resultsList.append(subItem)
            })
        })
        
        noResults = resultsList.count > 0 ? false : true
    }
}
