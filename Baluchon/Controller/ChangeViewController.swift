//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 25/10/2022.
//

import UIKit

class ChangeViewController: UIViewController {
    
    
    @IBOutlet weak var changeMoneyFromButton: UIButton!
    @IBOutlet weak var symbolFrom: UILabel!
    @IBOutlet weak var amountFrom: UITextField!
    @IBOutlet weak var exchangeRateFrom: UILabel!
    
    
    @IBOutlet weak var changeMoneyToButton: UIButton!
    @IBOutlet weak var symbolTo: UILabel!
    @IBOutlet weak var amountTo: UITextField!
    @IBOutlet weak var exchangeRateTo: UILabel!
    
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopChangeMoneyFromButton()
        setPopChangeMoneyToButton()
    }
    
    // MARK: - Selected Style Button
    
    enum Style {
        case USD, EUR
    }
    
    func setStyleButton(_ style: Style) {
        switch style {
        case .USD:
            symbolFrom.text = "$"
            symbolTo.text = "€"
            exchangeRateFrom.text = "1 USD = ... EUR"
            exchangeRateTo.text = "1 EUR = ... USD"
            
        case .EUR:
            symbolFrom.text = "€"
            symbolTo.text = "$"
            exchangeRateFrom.text = "1 EUR = ... USD"
            exchangeRateTo.text = "1 USD = ... EUR"
        }
    }
    // MARK: - Actions
    
    func setPopChangeMoneyFromButton( ) {
        
        let optionClosure = {(action : UIAction) in
            print(action.title)}
        
        changeMoneyFromButton.menu = UIMenu(children : [
            UIAction(title: "USD", state: .on, handler: optionClosure),
            UIAction(title: "EUR", handler: optionClosure)
        ])
        
        changeMoneyFromButton.showsMenuAsPrimaryAction = true
        changeMoneyFromButton.changesSelectionAsPrimaryAction = true
    }

    func setPopChangeMoneyToButton() {
        
        let optionClosure = {(action : UIAction) in
            print(action.title)}
        
        changeMoneyToButton.menu = UIMenu(children : [
            UIAction(title: "EUR", state: .on, handler: optionClosure),
            UIAction(title: "USD", handler: optionClosure)
        ])
        
        changeMoneyToButton.showsMenuAsPrimaryAction = true
        changeMoneyToButton.changesSelectionAsPrimaryAction = true
    }
}
