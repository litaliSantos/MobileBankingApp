//
//  ViewController.swift
//  MobileBankingApp
//
//  Created by Litali Calheiros on 11/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import Foundation
import UIKit

private var loaderView: UIView?
private var reachability: Reachability?

extension UIViewController {
    
    //MARK: - Alert
    /// Shows IOS Native alert
    /// - Parameter message: The error message
    func showErrorAlert(message: String) {
        
        let alert = UIAlertController(title: "Ops!", message: message,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Loader
    /// Shows a loading view over the current ViewController
    func showLoader() {
        if loaderView == nil {
            // creating loaderView
            loaderView = UIView(frame: UIScreen.main.bounds)
            loaderView!.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            
            // white view in center
            let centerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 100))
            centerView.backgroundColor = UIColor.appColor(.DarkGreenColor)?.withAlphaComponent(0.7)
            centerView.layer.cornerRadius = 10
            
            loaderView!.addSubview(centerView)
            centerView.center = loaderView!.center
            
            // stackview for loader and text
            let stackView = UIStackView(frame: centerView.frame)
            stackView.spacing = 8
            stackView.axis = .vertical
            
            // loader
            let loader = UIActivityIndicatorView(style: .gray)
            loader.color = .white
            loader.startAnimating()
            stackView.addArrangedSubview(loader)
            
            // add stackview as subview for centerView
            centerView.addSubview(stackView)
            
            // setup constraints
            stackView.translatesAutoresizingMaskIntoConstraints = false
            centerView.addConstraints([
                NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: centerView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: 0)
            ])
        }
        DispatchQueue.main.async {
            self.view.addSubview(loaderView!)
        }
    }
    
    /// Hides the loading view which is over the current ViewController
    func hideLoader() {
        if loaderView != nil {
            loaderView?.removeFromSuperview()
        }
    }
    
    //MARK: - Keyboard
    /// Hides keyboard when the view is tapped
    func dismissKeyBoardWhenViewDidTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - Reachability
    /// Setups internet reachability observable
    func setupReachability() {
        reachability = Reachability()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged(note:)),
            name: .reachabilityChanged,
            object: reachability
        )
        startNotifier()
    }
    
    private func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
    
    func stopNotifierReachability() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        DispatchQueue.main.async {
            if reachability.connection == .none {
                loaderView != nil ? self.hideLoader() : nil
                self.showErrorAlert(message: "Você não possui conexão com a internet")
            }
        }
    }
}

