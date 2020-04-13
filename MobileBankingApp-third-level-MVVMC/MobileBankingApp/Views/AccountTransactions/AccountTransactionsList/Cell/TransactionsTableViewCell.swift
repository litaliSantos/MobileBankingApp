//
//  TransactionsTableViewCell.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 10/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    // MARK: - Setup
    func setup(with transaction: Transaction, showArrowImage: Bool) {
        valueLabel.text = floatToBRLFormat(value: transaction.valor ?? 0)
        originLabel.text = transaction.origem
        
        guard let category = CategoryType(rawValue: transaction.categoria ?? 1) else { return }
        iconImageView.image = UIImage(named: getCategoryIconName(categoryId: category))?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.appColor(.orangeColor)
        arrowImage.isHidden = !showArrowImage
    }
}
