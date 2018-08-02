//
//  ViewController.swift
//  SubmitValue
//
//  Created by KyungYoung Heo on 2018. 8. 1..
//  Copyright © 2018년 KyungYoung Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBOutlet var isUpdatedText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.isUpdatedText.text = "Updated"
        } else {
            self.isUpdatedText.text = "Not Updated"
        }
        
    }
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    @IBAction func onSubmit(_ sender: Any){
        // VC2의 인스턴스 생성 후 옵셔널 캐스팅
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController
            else {
                return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        // 화면 이동
        self.present(rvc, animated: true)
    }
    @IBAction func onAction(_ sender: Any){
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController
            else {
                return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        // 네이게이션을 통한 화면 이동
        self.navigationController?.pushViewController(rvc, animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

