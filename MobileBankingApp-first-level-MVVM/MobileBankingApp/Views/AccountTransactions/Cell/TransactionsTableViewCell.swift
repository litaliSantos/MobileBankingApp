//
//  TransactionsTableViewCell.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 10/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {
    
    // MARK: - Category enum
    private enum Category: Int {
        case transport = 1
        case onlinePurchase = 2
        case beautyAndHealth = 3
        case automotiveService = 4
        case restaurant = 5
        case supermarket = 6
    }
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    // MARK: - Setup
    func setup(with transaction: Transaction) {
        valueLabel.text = floatToBRLFormat(value: transaction.valor ?? 0)
        originLabel.text = transaction.origem
        
        guard let category = Category(rawValue: transaction.categoria ?? 1) else { return }
        iconImageView.image = UIImage(named: getCategoryIconName(categoryId: category))?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.appColor(.OrangeColor)
    }
    
    // MARK: - Formatting Functions
    private func getCategoryIconName(categoryId: Category) -> String {
        switch categoryId {
        case .transport:
            return "TransportIcon"
        case .onlinePurchase:
            return "OnlinePurchaseIcon"
        case .beautyAndHealth:
            return "HealthIcon"
        case .automotiveService:
            return "AutomotiveServicesIcon"
        case .restaurant:
            return "RestaurantIcon"
        case .supermarket:
            return "SupermarketPurchaseIcon"
        }
    }
    
    /// Convert float value to Brazilian currency format
    /// - Parameter value: float to convert
    private func floatToBRLFormat(value: Float) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
