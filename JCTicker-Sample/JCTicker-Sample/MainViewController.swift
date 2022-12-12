//
//  ViewController.swift
//  JCTicker-Sample
//
//  Created by zexi chen on 2022-12-09.
//

import UIKit
import JCTicker
class MainViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var column: UITicker!
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        column.setDurantion(2.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
    }


    @IBAction func click(_ sender: Any) {
        
        guard let text = inputField.text else {return}
        
        column.animateTo(target: text)
        
    }
}

