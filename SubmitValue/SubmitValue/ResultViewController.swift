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
    
}
