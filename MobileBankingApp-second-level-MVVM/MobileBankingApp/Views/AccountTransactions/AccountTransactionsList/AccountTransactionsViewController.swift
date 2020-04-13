//
//  AccountTransactionsViewController.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 10/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SystemConfiguration

class AccountTransactionsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Constants and Variables
    private let viewModel = TransactionsViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopNotifierReachability()
    }
    
    // MARK: - Load Data
    private func loadData() {
        showLoader()
        setupReachability()
        viewModel.getTransactions(success: { [weak self] in
            guard let self = self else { return }
            self.viewModel.getCategories(success: {
                self.hideLoader()
                self.tableView.reloadData()
            }) { (errorMessage) in
                self.hideLoader()
                self.showErrorAlert(message: errorMessage)
            }
        }) { (errorMessage) in
            self.hideLoader()
            self.showErrorAlert(message: errorMessage)
        }
    }
    
    // MARK: - Setup
    private func setup() {
        loadData()
        setupTableView()
        setupTextField()
        dismissKeyBoardWhenViewDidTap()
        setCustomNavigationBar()
        setupReachability()
    }
    
    private func setupTableView() {
        tableView.registerNib(name: viewModel.transactionCellIdentifier)
        tableView.registerNib(name: viewModel.noResultsCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    private func setupTextField() {
        searchView.isHidden = true
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Search
    private func updateSearchView() {
        searchView.isHidden.toggle()
        
        viewModel.transactionList(shouldReset: searchView.isHidden)
        tableView.reloadData()
        
        let buttonIcon = searchView.isHidden ? "SearchIcon" : "CloseIcon"
        searchButton.setImage(UIImage(named: buttonIcon), for: .normal)
        
        UIView.animate(withDuration: 1,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.0,
                       options: .transitionCurlDown,
                       animations: {
                        self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Actions
    @IBAction func didTapSearchButton(_ sender: Any) {
        updateSearchView()
    }
    
    @IBAction func didTapCalendarButton(_ sender: Any) {
        push(viewController: MonthlyBalanceViewController(viewModel: viewModel))
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.searchFor(transaction: textField.text ?? "") { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate and DataSource
extension AccountTransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCell(tableView: tableView, indexPath: indexPath, searchTextFieldIsFirstResponder: searchTextField.isFirstResponder)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getAccountTransactionsListSectionTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.noResults {
            loadData()
        } else {
            push(viewController: TransactionDetailViewController(viewModel: viewModel, transactionIndexPath: indexPath))
        }
    }
}
