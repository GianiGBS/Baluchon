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
    
    func selectCurrencyFrom(){
        // verifier  si index optionArray == index Currency.list
        // symbolFrom.text = index.Currency.list.symbol
    }
    func selectCurrencyTo(){
        
    }

    // MARK: - Actions
    
    func setPopChangeMoneyFromButton() {
        
        // creation de la closure
        let optionClosure = {(action : UIAction) in
            print(action.title)
            self.selectCurrencyFrom()
        }
        
        // creation d'un tableau d'actions
        var optionsArray = [UIAction]()
        
        // boucle pour remplir le tableau d'actions
        for currency in Currency.list {
            let action = UIAction(title: currency.name, state: .off, handler: optionClosure)
            
            optionsArray.append(action)
        }
        
        // set the state of first country in the array as ON
        optionsArray[0].state = .on
        
        // add everything to your button
        changeMoneyFromButton.menu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        changeMoneyFromButton.showsMenuAsPrimaryAction = true
        changeMoneyFromButton.changesSelectionAsPrimaryAction = true
    }

    func setPopChangeMoneyToButton() {
        
        let optionClosure = {(action : UIAction) in
            print(action.title)
            
        }
        
        changeMoneyToButton.menu = UIMenu(children : [
            UIAction(title: "EUR", state: .on, handler: optionClosure),
            UIAction(title: "USD", handler: optionClosure),
            UIAction(title: "GBP", handler: optionClosure)
        ])
        
        changeMoneyToButton.showsMenuAsPrimaryAction = true
        changeMoneyToButton.changesSelectionAsPrimaryAction = true
    }
    
    // MARK: - Methods

}
