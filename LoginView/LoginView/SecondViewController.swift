//
//  SecondViewController.swift
//  LoginView
//
//  Created by KyungYoung Heo on 2017. 10. 17..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var accountInfo: AccountInfo!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idLabel.text=self.accountInfo.id
        self.passwordLabel.text=self.accountInfo.password
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
