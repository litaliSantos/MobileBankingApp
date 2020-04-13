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
    case DarkGrayColor
    case DarkGreenColor
    case LightGrayColor
    case OrangeColor
    case PrimaryColor
    case WhiteColor
}

//MARK: - UIColor Extension
extension UIColor {
    static func appColor(_ name: Colors) -> UIColor? {
        return UIColor.init(named: name.rawValue)
    }
}
