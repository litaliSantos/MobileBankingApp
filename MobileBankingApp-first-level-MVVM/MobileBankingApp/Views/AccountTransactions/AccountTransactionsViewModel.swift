//
//  AccountTransactionsViewModel.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 10/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

class AccountTransactionsViewModel {
    
    // MARK: - Constants
    private let queryService = QueryService()
    private let months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
    let transactionCellIdentifier = "TransactionsTableViewCell"
    let noResultsCellIdentifier = "NoResultsTableViewCell"
    let placeholderCellHeightAtSearch: CGFloat = 100
    
    // MARK: - Variables
    var transactionsByMonth: [[Transaction]] = []
    var transactionsByMonthFiltered: [[Transaction]] = []
    var noResults = true
    
    // MARK: - Request
    func getTransactions(success: @escaping()->(), error:@escaping (String)->()) {
        queryService.getTransactions(success: { [weak self] (transactions) in
            guard let self = self else { return }
            self.saveTransactionsResponse(transactions: transactions)
            success()
        }) { (errorMessage) in
            error(errorMessage)
        }
    }
    
    // MARK: - Save
    private func saveTransactionsResponse(transactions: [Transaction]) {
        for month in 1...12 {
            let monthTransactions = transactions.filter({$0.mes_lancamento == month})
            if  monthTransactions.count > 0 {
                self.transactionsByMonth.append(monthTransactions)
            }
        }
        self.transactionsByMonthFiltered = self.transactionsByMonth
        self.updateResults()
    }
    
    // MARK: - Getters
    func getPlaceholderCell(tableView: UITableView, allowsInteraction: Bool, isHeighDefinided: Bool) -> UITableViewCell {
        let noResultsCell = tableView.dequeueReusableCell(withIdentifier: noResultsCellIdentifier) as! NoResultsTableViewCell
        noResultsCell.showTryAgain(allowsInteraction)
        noResultsCell.isUserInteractionEnabled = allowsInteraction
        noResultsCell.selectionStyle = .none
        tableView.rowHeight = isHeighDefinided ? placeholderCellHeightAtSearch : tableView.frame.height
        return noResultsCell
    }
    
    func getTransactionsCell(tableView: UITableView, transaction: Transaction, showArrow: Bool) -> UITableViewCell {
        let transactionCell = tableView.dequeueReusableCell(withIdentifier: transactionCellIdentifier) as! TransactionsTableViewCell
        transactionCell.setup(with: transaction)
        transactionCell.selectionStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        return transactionCell
    }
    
    func getSectionTitle(section: Int) -> String? {
        if noResults {
            return nil
        } else {
            guard let sectionMonth = transactionsByMonthFiltered[section].first?.mes_lancamento else { return "" }
            return months[sectionMonth - 1]
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
