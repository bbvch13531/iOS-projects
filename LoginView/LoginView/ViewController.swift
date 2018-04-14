//
//  ViewController.swift
//  LoginView
//
//  Created by KyungYoung Heo on 2017. 10. 17..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idField.delegate = self
        self.passwordField.delegate = self
        
        print("view did load")
    }
   
    @IBAction func tapRootView(_ sender: UITapGestureRecognizer) {
        print("사용자가 뷰를 탭함")
        
//        if self.idField.isFirstResponder{
//            self.idField.resignFirstResponder()
//        }
//        else if self.passwordField.isFirstResponder{
//            self.passwordField.resignFirstResponder()
//        }
//
        self.view.endEditing(true)
    }
    
    //MARK: Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let second: SecondViewController=segue.destination as? SecondViewController else{return}
        
        guard let id: String = self.idField.text else{
            print("아이디를 입력하세요")
            return
        }
        guard let password: String = self.passwordField.text else{
            print("패스워드를 입력하세요")
            return
        }
        let info: AccountInfo=AccountInfo(id: id, password: password)
        second.accountInfo=info
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
}

