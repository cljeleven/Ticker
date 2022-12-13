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
        column.setDurantion(1.5)
        column.setSuffix("ml")
        column.setValue(input: "0")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // demo()
    }
    
    
    @IBAction func click(_ sender: Any) {
//        demo()
        guard let text = inputField.text else {return}

        column.animateTo(target: text)

    }
    
    
    func demo() {
        let interval = 2.2
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.column.animateTo(target: "8888")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1) {
            self.column.animateTo(target: "23471.56")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 2) {
            self.column.animateTo(target: "1234526.24")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 3) {
            self.column.animateTo(target: "1231234486.1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 4) {
            self.column.animateTo(target: "2371.56")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 5) {
            self.column.animateTo(target: "321.5")
        }
    }
}

