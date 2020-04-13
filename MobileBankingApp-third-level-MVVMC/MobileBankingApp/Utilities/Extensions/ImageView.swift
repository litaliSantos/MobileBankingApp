//
//  ImageView.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Renders the asset as template and set its color
    /// - Parameter color: chosen color
    func setColor(color: UIColor){
        image = image!.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
