//
//  MonthlyBalanceViewController.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

class MonthlyBalanceViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - Initialization
    convenience required init(viewModel: TransactionsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Variables
    private var viewModel: TransactionsViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.monthlyBalanceViewTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setupCollectionView()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        collectionView.registerNib(named: viewModel.monthCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        selectFirstMonth()
    }
    
    private func setupTableView() {
        tableView.registerNib(name: viewModel.transactionCellIdentifier)
        tableView.registerNib(name: viewModel.noResultsCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    private func selectFirstMonth() {
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        viewModel.selectedMonthIndex = 0
    }
    
    // MARK: - Update State
    private func updateExpensesLabel() {
        balanceLabel.text = viewModel.getMonthExpenses()
    }
}

// MARK: - CollectionView Delegate and DataSource
extension MonthlyBalanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.monthCellIdentifier, for: indexPath) as! MonthsCollectionViewCell
        cell.setup(month: months[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedMonthIndex = indexPath.row
        tableView.reloadData()
    }
}

//MARK: - CollectionView FlowLayout
extension MonthlyBalanceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel!.monthCellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModel.monthCellWidht, height: viewModel.monthCellHeight)
    }
}

//MARK: - TableView Delegate and DataSource
extension MonthlyBalanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateExpensesLabel()
        return viewModel.getMonthlyNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getMonthlyCell(tableView: tableView, indexPath: indexPath)
    }
}
