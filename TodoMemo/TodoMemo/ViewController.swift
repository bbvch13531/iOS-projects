//
//  ViewController.swift
//  TodoMemo
//
//  Created by KyungYoung Heo on 2017. 10. 29..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveUpdateTodoListNotification(_:)), name: didUpdateTodoListNotification, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate=self
        self.tableView.dataSource=self
        
        self.tableView.refreshControl=UIRefreshControl()
//        self.tableView.refreshControl?.addTarget(self,action:#selector(self.startReloadTableContents(_:)),for:UIControlEvents.valueChanged)
    }
    
    //MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell=tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        cell.textLabel?.text=todos[indexPath.row].title
        cell.textLabel?.text=dateFormatter.string(from: todos[indexPath.row].due)
//        if indexPath.row%2==1{
//            cell.backgroundColor=UIColor.gray
//
//        }else {
//            cell.backgroundColor=UIColor.white
//
//        }
//
//        cell.textLabel?.text="\(indexPath.section)"
//        cell.detailTextLabel?.text="\(indexPath.row)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return todos.count
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

