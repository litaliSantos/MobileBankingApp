//
//  TransactionDetailViewController.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - Initialization
    convenience required init(viewModel: TransactionsViewModel, transactionIndexPath: IndexPath) {
        self.init()
        self.viewModel = viewModel
        self.indexPath = transactionIndexPath
    }
    
    // MARK: - Variables
    private var viewModel: TransactionsViewModel!
    private var indexPath: IndexPath?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Setup
    private func setupView() {
        iconBackgroundView.makeItCircular()

        guard let index = indexPath else { return }
        let transaction = viewModel.transactionsByMonthFiltered[index.section][index.row]
        
        guard let category = CategoryType(rawValue: transaction.categoria ?? 0) else { return }
        let icon = UIImage(named: getCategoryIconName(categoryId: category))?.withRenderingMode(.alwaysTemplate)
        iconImageView.image = icon
        iconImageView.setColor(color: .white)
        
        guard let categoryName = viewModel.categories.first(where: {$0.id == transaction.categoria}) else { return }
        categoryNameLabel.text = categoryName.nome
        
        dateLabel.text = getMonthName(month: transaction.mes_lancamento ?? 1)
        idLabel.text = String(transaction.id ?? 0)
        originLabel.text = transaction.origem
        valueLabel.text = floatToBRLFormat(value: transaction.valor ?? 0)
    }
    
    // MARK: - Share
    /// Captures the current view and open a share activity
    private func performShareAction() {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        _ = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        let activityViewController = UIActivityViewController(activityItems: [view.image()], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        self.present(activityViewController, animated: true, completion: nil)
    }

    // MARK: - Actions
    @IBAction func didTapShareButton(_ sender: Any) {
        performShareAction()
    }
}
