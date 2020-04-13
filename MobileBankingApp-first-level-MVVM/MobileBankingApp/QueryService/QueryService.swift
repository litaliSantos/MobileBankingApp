//
//  QueryService.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import SystemConfiguration

class QueryService {
    
    // MARK: - Constants
    let getTransactions = "https://desafio-it-server.herokuapp.com/lancamentos"
    let getCategories = "https://desafio-it-server.herokuapp.com/categorias"
    let defaultSession = URLSession(configuration: .default)
    
    // MARK: - Variables And Properties
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var transactions: [Transaction] = []
    
    // MARK: - Type Alias
    typealias JSONDictionary = [String: Any]
    typealias SuccessResultGetTransactions = ([Transaction]) -> ()
    typealias ErrorResult = (String) -> ()
    
    // MARK: - Internal Methods
    func getTransactions(success: @escaping SuccessResultGetTransactions, onError: @escaping ErrorResult) {
        
        dataTask?.cancel()
        
        guard let urlComponents = URLComponents(string: getTransactions) else { return }
        guard let url = urlComponents.url else {
            return
        }
        
        self.dataTask = self.defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer {
                self.dataTask = nil
            }
            
            guard let dataResponse = data,
                let response = response,
                error == nil
                else {
                    self.errorMessage += "DataTask error: " + (error?.localizedDescription ?? "") + "\n"
                    return
            }
            
            let urlResponse = response as? HTTPURLResponse
            
            DispatchQueue.main.async {
                if urlResponse?.statusCode == 200 {
                    self.updateTransactions(dataResponse)
                    success(self.transactions)
                } else {
                    onError(self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
    
    // MARK: - Private Methods
    func updateTransactions(_ data: Data) {
        var response: [Transaction]?
        transactions.removeAll()
        
        do{
            let decoder = JSONDecoder()
            response = try decoder.decode([Transaction].self, from: data)
        } catch let parsingError as NSError {
            errorMessage += "JSONSerialization error: \(parsingError.localizedDescription)\n"
            return
        }
        
        guard let responseList = response else { return }
        print(responseList)
        
        for transaction in responseList {
            transactions.append(transaction)
        }
    }
}
