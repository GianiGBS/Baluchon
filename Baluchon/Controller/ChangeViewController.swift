//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 25/10/2022.
//

import UIKit

class ChangeViewController: UIViewController {
    
    @IBOutlet weak var changeMoneyFromButton: UIButton!
    
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var symbolFrom: UILabel!
    @IBOutlet weak var amountFrom: UITextField!
    @IBOutlet weak var exchangeRateFrom: UILabel!
    
    @IBOutlet weak var convertButton: UIButton!
    
    
    @IBOutlet weak var changeMoneyToButton: UIButton!
    
    @IBOutlet weak var textFieldTo: UITextField!
    @IBOutlet weak var symbolTo: UILabel!
    @IBOutlet weak var amountTo: UITextField!
    @IBOutlet weak var exchangeRateTo: UILabel!
    
    var changeMoneyFromPickerView = UIPickerView()
    var changeMoneyToPickerView = UIPickerView()
    
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerView()
        tagPickerView()
    }
    // MARK: - Actions
    
    @IBAction func convert(_ sender: Any) {
        amountTextFieldShouldReturn(textField: amountFrom)
    }
    // MARK: - Functions
    
    private func callChangeNetworkServices(with amountToChange: String){
        ChangeService.shared.getChange(with: amountToChange) { success, change in
            guard let change = change, success == true else {
                self.presentAlert(title: "Echec de l'appel", message: "Fixer.API n'a pas répondu.\nVeuillez réessayer.")
                return
            }
            self.update(change: change)
        }
    }
    
    private func update(change: Change) {
        amountTo.text = "\(change.result)"
        exchangeRateFrom.text = "1 \(change.query.from) = \(change.info.rate) \(change.query.to)"
    }
    
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func setPickerView(){
        textFieldFrom.inputView = changeMoneyFromPickerView
        textFieldTo.inputView = changeMoneyToPickerView
        
        changeMoneyFromPickerView.delegate = self
        changeMoneyFromPickerView.dataSource = self
        changeMoneyToPickerView.delegate = self
        changeMoneyToPickerView.dataSource = self
    }
    
    func tagPickerView(){
        changeMoneyFromPickerView.tag = 1
        changeMoneyToPickerView.tag = 2
    }
}

// MARK: - PickerView

extension ChangeViewController : UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Currency.list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currency.list[row].name
    }

    func pickerView(_ pickerView : UIPickerView, didSelectRow row : Int, inComponent component : Int) {
        switch pickerView.tag {
        case 1:
            let currentCurrencySelectedFrom = Currency.list[row]
            Currency.currentCurrencyFromCodeISO = currentCurrencySelectedFrom.codeISO
            textFieldFrom.text = currentCurrencySelectedFrom.name
            textFieldFrom.resignFirstResponder()
            symbolFrom.text = currentCurrencySelectedFrom.symbol
            
        case 2:
            let currentCurrencySelectedTo = Currency.list[row]
            Currency.currentCurrencyToCodeISO = currentCurrencySelectedTo.codeISO
            textFieldTo.text = currentCurrencySelectedTo.name
            textFieldTo.resignFirstResponder()
            symbolTo.text = currentCurrencySelectedTo.symbol
            
        default:
            return
        }
    }
    
    func amountTextFieldShouldReturn(textField: UITextField) {
        guard let amountTochange = textField.text else{
            self.presentAlert(title: "Entrée vide",
                             message: "Veuillez réessayer une nouvelle valeur d'entrée.")
            return
        }
        textField.resignFirstResponder()
        callChangeNetworkServices(with: amountTochange)
        return
    }

}


//    func dismissPickerViewTo() {
//       let toolBar = UIToolbar()
//       toolBar.sizeToFit()
//       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
//       toolBar.setItems([button], animated: true)
//       toolBar.isUserInteractionEnabled = true
//       textFieldTo.inputAccessoryView = toolBar
//    }
//    @objc func action() {
//          view.endEditing(true)
//    }
//}
