//
//  ImageDownloadViewController.swift
//  ImagePicker
//
//  Created by KyungYoung Heo on 2017. 10. 19..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class ImageDownloadViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlField: UITextField!
    
    lazy var indicator: UIActivityIndicatorView={
        let indicator: UIActivityIndicatorView=UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        indicator.backgroundColor=UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints=false
        return indicator
    }()
    func showActivityIndicator(){
        self.view.addSubview(self.indicator)
        
        let safeAreaLayoutGuide: UILayoutGuide=self.view.safeAreaLayoutGuide
        
        self.indicator.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive=true
        self.indicator.centerYAnchor.constraint(equalTo:safeAreaLayoutGuide.centerYAnchor).isActive=true
        
        indicator.startAnimating()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible=true
    }
    func hideActivityIndicator(){
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible=false
    }
    @IBAction func touchUpSyncDownloadButton(_ sender: UIButton){
        self.urlField.endEditing(true)
        self.showActivityIndicator()
    
        guard let urlString: String = self.urlField.text,
            urlString.isEmpty == false else{
                return
        }
        guard let url=URL(string: urlString) else{
                return
        }
        
        do{
            let data=try Data(contentsOf: url)
            let image = UIImage(data: data)
            self.imageView.image = image
        }catch{
            print(error.localizedDescription)
        }
        self.hideActivityIndicator()
    }
    
    
    @IBAction func touchUpAsyncDownloadButton(_ sender: UIButton){
        self.urlField.endEditing(true)
        self.showActivityIndicator()
        
        guard let urlString: String = self.urlField.text,
            urlString.isEmpty == false else{
                return
        }
        guard let url=URL(string: urlString) else{
            return
        }
        //let downloadQueue: DispatchQueue=DispatchQueue(label:"image_download")
        //downloadQueue.async{
        DispatchQueue.global().async{
            defer{
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
            }
            do{
                let data=try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
