//
//  NoResultsTableViewCell.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import UIKit

class NoResultsTableViewCell: UITableViewCell {

    // MARK: - Oulets
    @IBOutlet weak var tryAgainLabel: UILabel!
    
    // MARK: - Life cylce
    override func awakeFromNib() {
        super.awakeFromNib()
        tryAgainLabel.isHidden = true
    }
    
    // MARK: - Functions
    func showTryAgain(_ show: Bool) {
        tryAgainLabel.isHidden = !show
    }
}
