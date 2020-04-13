//
//  TableView.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // MARK: - RegisterNib
    func registerNib(name: String){
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
