//
//  Colors.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Custom colors assets enum
enum Colors: String {
    case darkGrayColor
    case darkGreenColor
    case lightGrayColor
    case orangeColor
    case primaryColor
    case whiteColor
}

//MARK: - UIColor Extension
extension UIColor {
    static func appColor(_ name: Colors) -> UIColor? {
        return UIColor.init(named: name.rawValue)
    }
}
