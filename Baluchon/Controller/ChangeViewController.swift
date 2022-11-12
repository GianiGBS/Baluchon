//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 25/10/2022.
//

import UIKit

class ChangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Verification clé
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_CHANGE_KEY") as? String
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
