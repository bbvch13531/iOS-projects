//
//  DetailViewController.swift
//  tableView
//
//  Created by KyungYoung Heo on 2017. 10. 30..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController{
   
    
    @IBOutlet weak var LargePic: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var CellNum: UILabel!
    @IBOutlet weak var Nat: UILabel!
    
    //친구정보의 저장여부를 판단하는 변수
    var isSaved: Bool = false
    
    ///bestFriends에 저장된 index를 계산하는 함수
    func GetIndex() -> Int {
        var count: Int = 0
        for vo in bestFriends {
            if vo.cellNum == fvo.cellNum {
                return count
            }
            count = count + 1
        }
        return -1
    }
    
    /// 저장을 눌렀을 때 bestFriends에 저장하는 함수
    @IBAction func AddBestFriend() {
        
        //이미 저장되었을 때
        if isSaved == true {
            //count에 저장된 index 저장
            var count = GetIndex()
            
            //count번째에 저장된 데이터 삭제
            bestFriends.remove(at: count)
            
            //bestFriendsList에 저장
            SaveBestFriendsList()
            
            //추가되어있지 않은 친구이므로 버튼을 .add로 바꾸고 isSaved를 false로 바꾼다.
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: "AddBestFriend")
            isSaved = false
            return
        }
        
        //저장되어있지 않을 때
        
        //bestFriends에 추가
        bestFriends.append(self.fvo)
        
        //bestFriendsList에 저장
        SaveBestFriendsList()
        
        //추가된 친구이므로 버튼을 .trash로 바꾸고 isSaved를 true로 바꾼다.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,target: self, action: "AddBestFriend")
        isSaved = true
    }
    
    /// 친구가 bestFriends에 있는지 판별하는 함수
    ///
    /// - Returns: 저장되어있으면 true, 아니면 false
    func IsSaved() -> Bool {
        if (bestFriends.contains(where: {$0.cellNum == fvo.cellNum})) {
            return true
        }
        else {
            return false
        }
    }
    
    var fvo : FriendVO!
    
    /// viewDidLoad일때 실행되는 함수
    /// 가장 먼저 실행됨
    override func viewDidLoad() {
        
        //nagivation bar의 타이틀에 친구 이름을 출력
        let navibar = self.navigationItem
        navibar.title = self.fvo?.name
        
        //저장된 url을 이미지로 변환해서 화면에 출력
        let url: URL! = URL(string: self.fvo!.largePic!)
        let imageData = try! Data(contentsOf: url)
        LargePic.image=UIImage(data:imageData)
        
        //기타 정보 label에 출력
        Name.text=self.fvo?.name
        Email.text=self.fvo?.email
        CellNum.text=self.fvo?.cellNum
        Nat.text=self.fvo?.nat
        
    }
    
    /// view가 appear될 때마다 실행되는 함수.
    /// 상황에 맞는 오른쪽 barButtonItem을 설정함.
    /// - Parameter animated: animated: Bool
    override func viewDidAppear(_ animated: Bool) {
        
        //저장된 친구일 때
        if IsSaved() == true {
            
            //barButtonItem을 .trash로 바꾸고 저장되어있음을 표시
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,target: self, action: "AddBestFriend")
            isSaved = true
        }
        //저장되지 않은 친구일 때
        else {
            //barButtonItem을 .add로 바꾸고 저장되어있지 않음을 표시
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: "AddBestFriend")
            isSaved = false
        }
    }
    
    /// WebView에게 정보를 전달해주는 함수
    ///
    /// - Parameters:
    ///   - segue: UIStoryboardSegue의 segue에 적용
    ///   - sender: Any?로 받음
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        //segue의 식별자가 segueSearchOnWeb이면
        if segue.identifier == "segueSearchOnWeb"{
            
            //행 정보를 통해 선택된 친구 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 fvo에 대입
            let web = segue.destination as? WebViewController
            web?.url="http://www.google.com/search?q=" + fvo.nat!
        }
        
    }
}
