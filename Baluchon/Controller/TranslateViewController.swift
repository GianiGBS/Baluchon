//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var translateFromButton: UIButton!
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var textViewFrom: UITextView!
    
    
    @IBOutlet weak var translateToButton: UIButton!
    @IBOutlet weak var textFieldTo: UITextField!
    @IBOutlet weak var textViewTo: UITextView!
    

    var translateFromPickerView = UIPickerView()
    var translateToPickerView = UIPickerView()
    
    // MARK: - Navigation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerView()
        tagPickerView()
        
        
    }
    
    // MARK: - Functions
    
    private func callTranslateNetworkServices(with textToTranslate: String) {
        TranslateService.shared.getTranslate(with: textToTranslate) { success, translatedText in
            guard let translatedText = translatedText, success == true else {
                self.presentAlert(title: "Echec de l'appel", message: "Google n'a pas répondu.\nVeuillez réessayer.")
                return
            }
            self.update(translatedText: translatedText)
        }
    }
    private func update(translatedText: String) {
        textViewTo.text = translatedText
        
    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    func setPickerView(){
        textFieldFrom.inputView = translateFromPickerView
        textFieldTo.inputView = translateToPickerView
        
        translateFromPickerView.delegate = self
        translateFromPickerView.dataSource = self
        translateToPickerView.delegate = self
        translateToPickerView.dataSource = self
    }
    
    func tagPickerView(){
        translateFromPickerView.tag = 1
        translateToPickerView.tag = 2
    }
    
}

// MARK: - PickerView

extension TranslateViewController: UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
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
        callTranslateNetworkServices(with: textToTranslate)
        textViewTo.resignFirstResponder()
    }
}

