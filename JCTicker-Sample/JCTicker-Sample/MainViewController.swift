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
    @IBOutlet weak var firstTicker: UITicker!
    @IBOutlet weak var secondTicker: UITicker!

    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstTicker.setDurantion(1.5)
        firstTicker.setSuffix("ml")
        firstTicker.setValue(input: "0")
        
        secondTicker.setDurantion(1.5)
        secondTicker.setSuffix("ml")
        secondTicker.setValue(input: "0")
        secondTicker.setInterpolator(OverShootInterpolator())
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // demo()
    }
    
    
    @IBAction func click(_ sender: Any) {
//        demo()
        guard let text = inputField.text else {return}

        firstTicker.animateTo(target: text)
        secondTicker.animateTo(target: text)
    }
    
    
    func demo() {
        let interval = 2.2
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.firstTicker.animateTo(target: "8888")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1) {
            self.firstTicker.animateTo(target: "23471.56")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 2) {
            self.firstTicker.animateTo(target: "1234526.24")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 3) {
            self.firstTicker.animateTo(target: "1231234486.1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 4) {
            self.firstTicker.animateTo(target: "2371.56")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 5) {
            self.firstTicker.animateTo(target: "321.5")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.secondTicker.animateTo(target: "8888")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1) {
            self.secondTicker.animateTo(target: "23471.56")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 2) {
            self.secondTicker.animateTo(target: "1234526.24")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 3) {
            self.secondTicker.animateTo(target: "1231234486.1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 4) {
            self.secondTicker.animateTo(target: "2371.56")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval * 5) {
            self.secondTicker.animateTo(target: "321.5")
        }
    }
}

