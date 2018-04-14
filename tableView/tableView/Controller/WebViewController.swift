//
//  WebViewController.swift
//  tableView
//
//  Created by KyungYoung Heo on 2017. 11. 2..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController{
    @IBOutlet weak var WebViewPage: UIWebView!
    var url:String?
    
    //뒤로가기
    @IBAction func goBack(_ sender: Any) {
        WebViewPage.goBack()
    }
    
    //로딩 중지
    @IBAction func stopLoading(_ sender: Any) {
        WebViewPage.stopLoading()
    }
    
    //새로고침
    @IBAction func reload(_ sender: Any) {
        WebViewPage.reload()
    }
    
    //앞으로가기
    @IBAction func goForward(_ sender: Any) {
        WebViewPage.goForward()
    }
    
    //창 닫기
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // url주소에 request해서 웹뷰페이지에 load함
        WebViewPage?.loadRequest(URLRequest(url: URL(string: url!)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
