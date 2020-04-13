//
//  MonthlyBalanceViewModelExtension.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AccountTransactionsViewController tableView getters
extension TransactionsViewModel {
    /// Returns the index of the list that contains the transactions of the month selected at collectionView
    private func getSelectedMonthListIndex() -> Int? {
        let index  = transactionsByMonth.firstIndex { (transaction) -> Bool in
            transaction.first?.mes_lancamento == selectedMonthIndex + 1
        }
        
        guard let transactionIndex = index else { return nil }
        return transactionIndex
    }
    
    func getMonthExpenses() -> String {
        var expenses: Float = 0
        if let listIndex = getSelectedMonthListIndex() {
            expenses = transactionsByMonth[listIndex].map { ($0.valor ?? 0) }.reduce(0, +)
        }
        return floatToBRLFormat(value: expenses)
    }
    
    func getMonthlyNumberOfRows() -> Int {
        guard let listIndex = getSelectedMonthListIndex() else { return 1 }
        return transactionsByMonth[listIndex].count
    }
    
    func getMonthlyCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let listIndex = getSelectedMonthListIndex() {
            let transaction = transactionsByMonth[listIndex][indexPath.row]
            let cell = getTransactionsCell(tableView: tableView, transaction: transaction, showArrow: false)
            return cell
        } else {
            let noResultsCell = getPlaceholderCell(tableView: tableView, allowsInteraction: false, isHeighDefinided: false)
            return noResultsCell
        }
    }
}
