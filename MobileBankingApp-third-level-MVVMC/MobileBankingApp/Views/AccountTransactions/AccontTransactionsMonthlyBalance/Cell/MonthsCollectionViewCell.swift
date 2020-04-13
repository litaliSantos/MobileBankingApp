//
//  MonthsCollectionViewCell.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

class MonthsCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var backgroundContentView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: - Constants
    let viewCornerRadius: CGFloat = 6
    let cellSelectedFontSize: CGFloat = 17
    let cellDeselectedFontSize: CGFloat = 15
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundContentView.layer.cornerRadius = viewCornerRadius
    }
    
    //MARK: - Is Selected
    override var isSelected: Bool {
        didSet {
            if isSelected {
                monthLabel.textColor = UIColor.appColor(.whiteColor)
                monthLabel.font = .boldSystemFont(ofSize: cellSelectedFontSize)
                backgroundContentView.backgroundColor = UIColor.appColor(.darkGreenColor)
            } else {
                monthLabel.textColor = .darkGray
                monthLabel.font = .boldSystemFont(ofSize: cellDeselectedFontSize)
                backgroundContentView.backgroundColor = UIColor.appColor(.whiteColor)
            }
        }
    }
    
    // MARK: - Setup
    func setup(month: String) {
        monthLabel.text = month
    }
}
