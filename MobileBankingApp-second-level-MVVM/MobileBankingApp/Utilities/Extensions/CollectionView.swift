//
//  CollectionView.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    // MARK: - RegisterNib
    func registerNib(named name: String){
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
}
