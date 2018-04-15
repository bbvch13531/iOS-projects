//
//  AddTodoViewController.swift
//  TodoMemo
//
//  Created by KyungYoung Heo on 2017. 10. 29..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dueField: UITextField!
    
    var datePicker: UIDatePicker!
    
    @IBAction func touchUpSaveButton(_ sender: UIButton){
        guard let title: String=self.titleField.text, title.isEmpty == false else{
            print("please input title")
            return
        }
        guard let dueText: String = self.dueField.text, dueText.isEmpty==false else{
            print("please inpute date")
            return
        }
        guard let due: Date = dateFormatter.date(from: dueText) else{
            print("wrond date string")
            return
        }
        let newTodo: TodoInfo = TodoInfo(title: title,
                                         due: due)
        todos.append(newTodo)
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func touchUpCancelButton(_ sender: UIButton){
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    //MARKL Receive Notification
//    @objc func didReceiveUpdateTodoListNotification(_ notification: Notification){
//        self.tableView.reloadData()
//    }
    //MARK: Custom Methods
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        print(sender.date)
        
        self.dueField.text=dateFormatter.string(from: sender.date)
    }
    @objc func touchUpDoneBarButton(){
        self.view.endEditing(true)
    }
    func initializeDatePicker(){
        self.datePicker=UIDatePicker()
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
        let toolbar:UIToolbar=UIToolbar();
        toolbar.sizeToFit()
        
        let spaceButton=UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.flexibleSpace,target: nil, action: nil)
        let doneButton=UIBarButtonItem(title:"완료", style:UIBarButtonItemStyle.done, target: self, action:#selector(self.touchUpDoneBarButton))
        toolbar.setItems([spaceButton,doneButton], animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeDatePicker()
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
