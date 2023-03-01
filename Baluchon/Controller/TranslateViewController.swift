//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var translateFromButton: UIButton!
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var textViewFrom: UITextView!

    @IBOutlet weak var translateToButton: UIButton!
    @IBOutlet weak var textFieldTo: UITextField!
    @IBOutlet weak var textViewTo: UITextView!

    // MARK: - Properties
    var translateFromPickerView = UIPickerView()
    var translateToPickerView = UIPickerView()
    let translateManager = TranslateManager()

    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()

        setPickerView()
        tagPickerView()
    }

    // MARK: - Methods
    func setPlaceholderToTextView() {

    }

    func setPickerView() {
        textFieldFrom.inputView = translateFromPickerView
        textFieldTo.inputView = translateToPickerView

        translateFromPickerView.delegate = self
        translateFromPickerView.dataSource = self
        translateToPickerView.delegate = self
        translateToPickerView.dataSource = self
    }

    func tagPickerView() {
        translateFromPickerView.tag = 1
        translateToPickerView.tag = 2
    }
}

// MARK: - Delegate Pattern
extension TranslateViewController: ViewDelegate {
    func updateView() {
        guard let data = translateManager.data, !data.isEmpty else {
            return self.presentAlert(title: "Erreur", message: "Aucune données.")
    }
        textViewTo.text = translateManager.data!
    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}

// MARK: - PickerView
extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Languages.list.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Languages.list[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            let currentLanguageSelectedFrom = Languages.list[row]
            Languages.currentLanguageFromCodeISO = currentLanguageSelectedFrom.codeISO
            textFieldFrom.text = currentLanguageSelectedFrom.name
            textFieldFrom.resignFirstResponder()
        case 2:
            let currentLanguageSelectedTo = Languages.list[row]
            Languages.currentLanguageToCodeISO = currentLanguageSelectedTo.codeISO
            textFieldTo.text = currentLanguageSelectedTo.name
            textFieldTo.resignFirstResponder()
        default:
            return
        }
        guard let textToTranslate = textViewFrom.text else {
            self.presentAlert(title: "Petit problème",
                              message: "Google traduction n'a pas répondu.\nVeuillez réessayer.")
            return
        }
        textViewTo.resignFirstResponder()
        translateManager.getData(textToTranslate: textToTranslate)
    }
}
