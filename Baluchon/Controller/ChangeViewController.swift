//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 25/10/2022.
//
// 
import UIKit

class ChangeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var changeMoneyFromButton: UIButton!
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var symbolFrom: UILabel!
    @IBOutlet weak var amountFrom: UITextField!
    @IBOutlet weak var exchangeRateFrom: UILabel!

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var changeMoneyToButton: UIButton!
    @IBOutlet weak var textFieldTo: UITextField!
    @IBOutlet weak var symbolTo: UILabel!
    @IBOutlet weak var amountTo: UITextField!
    @IBOutlet weak var exchangeRateTo: UILabel!

    // MARK: - Properties
    var changeMoneyFromPickerView = UIPickerView()
    var changeMoneyToPickerView = UIPickerView()
    let changeManager = ChangeManager()

    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        changeManager.delegate = self
        setPickerView()
        tagPickerView()
        textFieldFrom.text = Currency.list[0].name
        textFieldTo.text = Currency.list[2].name
    }

    // MARK: - Actions
    @IBAction func convert(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        amountTextFieldShouldReturn(textField: amountFrom)
    }

    // MARK: - Methods
    func setPickerView() {
        textFieldFrom.inputView = changeMoneyFromPickerView
        textFieldTo.inputView = changeMoneyToPickerView

        changeMoneyFromPickerView.delegate = self
        changeMoneyFromPickerView.dataSource = self
        changeMoneyToPickerView.delegate = self
        changeMoneyToPickerView.dataSource = self
    }

    func tagPickerView() {
        changeMoneyFromPickerView.tag = 1
        changeMoneyToPickerView.tag = 2
    }
}

    // MARK: - Delegate Pattern
extension ChangeViewController: ViewDelegate {
    func updateView() {
        toggleActivityIndicator(shown: false)
        guard let data = changeManager.data, !data.date.isEmpty else {
            return self.presentAlert(title: "Erreur", message: "Aucune données.")
    }
        amountTo.text = "\(round(Double(data.result) * 100)/100.0)"

        exchangeRateFrom.text = "1 \(data.query.from) = \(round(Double(data.info.rate) * 100)/100.0) \(data.query.to)"

        exchangeRateTo.text = "1 \(data.query.to) = \(round((1/(data.info.rate)) * 100)/100.0) \(data.query.from)"
    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    internal func toggleActivityIndicator(shown: Bool) {
        convertButton.isUserInteractionEnabled = !shown
        activityIndicator.isHidden = !shown
    }
}

    // MARK: - PickerView
extension ChangeViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Currency.list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currency.list[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
        guard let amountTochange = textField.text, !amountTochange.isEmpty else {
            return self.presentAlert(title: "Entrée vide",
                                     message: "Veuillez réessayer une nouvelle valeur d'entrée.")
        }
        textField.resignFirstResponder()
        changeManager.getData(amountToChange: amountTochange)
        return
    }
}
