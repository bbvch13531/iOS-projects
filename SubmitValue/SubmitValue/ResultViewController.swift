//
//  ResultViewController.swift
//  SubmitValue
//
//  Created by KyungYoung Heo on 2018. 8. 1..
//  Copyright © 2018년 KyungYoung Heo. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    var paramEmail: String = ""
    var paramUpdate: Bool = true
    var paramInterval: Double = 0
    
    @IBAction func onBack(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        self.resultEmail.text = paramEmail;
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신안함")
        self.resultInterval.text = "\(Int(paramInterval))분 마다 갱신"
    }
    
    
}
