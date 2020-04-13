//
//  AppUtility.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation

// MARK: - Category enum
enum CategoryType: Int {
    case transport = 1
    case onlinePurchase = 2
    case beautyAndHealth = 3
    case automotiveService = 4
    case restaurant = 5
    case supermarket = 6
}

// MARK: - Global Constants
let months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

// MARK: - Global Functions
func getCategoryIconName(categoryId: CategoryType) -> String {
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
func floatToBRLFormat(value: Float) -> String{
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "pt-BR")
    formatter.numberStyle = .currency
    return formatter.string(from: NSNumber(value: value)) ?? ""
}

func getMonthName(month: Int) -> String {
    return months[month - 1]
}
