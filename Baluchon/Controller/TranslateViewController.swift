//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import UIKit

class TranslateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Verification clé
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_TANSLATE_KEY") as? String
        guard let key = apiKey, !key.isEmpty else {
            print("API key does not exist")
            return
        }
        print("REST API key:", key)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
