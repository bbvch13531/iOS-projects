//
//  SecondViewController.swift
//  HelloWorld
//
//  Created by KyungYoung Heo on 2018. 7. 20..
//  Copyright © 2018년 KyungYoung Heo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func back2(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
