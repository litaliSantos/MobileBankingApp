//
//  Transaction.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let id: Int?
    let valor: Float?
    let origem: String?
    let categoria: Int?
    let mes_lancamento: Int?
}
