//
//  AccountTransactionsViewModel.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 10/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

class TransactionsViewModel {
    
    // MARK: - Constants
    private let queryService = QueryService()
    let transactionCellIdentifier = "TransactionsTableViewCell"
    let noResultsCellIdentifier = "NoResultsTableViewCell"
    let monthCellIdentifier = "MonthsCollectionViewCell"
    let monthlyBalanceViewTitle = "Extrato Mensal"
    
    //Cells layout
    var selectedMonthIndex = 0
    let monthCellSpacing: CGFloat = 16
    let monthCellWidht: CGFloat = 120
    let monthCellHeight: CGFloat = 40
    let placeholderCellHeightAtSearch: CGFloat = 100
    
    // MARK: - Variables
    var transactionsByMonth: [[Transaction]] = []
    var transactionsByMonthFiltered: [[Transaction]] = []
    var categories: [Category] = []
    var noResults = true
    
    // MARK: - Request
    func getTransactions(success: @escaping()->(), error: @escaping (String)->()) {
        queryService.getTransactions(success: { [weak self] (transactions) in
            guard let self = self else { return }
            self.saveTransactionsResponse(transactions: transactions)
            success()
        }) { (errorMessage) in
            error(errorMessage)
        }
    }
    
    func getCategories(success: @escaping()->(), error: @escaping (String)->()) {
        queryService.getCategories(success: { [weak self] (categories) in
            guard let self = self else { return }
            self.categories = categories
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
    
    // MARK: - Cells
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
        transactionCell.setup(with: transaction, showArrowImage: showArrow)
        transactionCell.selectionStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        return transactionCell
    }
}
