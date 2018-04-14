//
//  FriendsViewController.swift
//  tableView
//
//  Created by KyungYoung Heo on 2017. 10. 30..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class FriendsViewController : UITableViewController{
    
    //Cell에 추가할 FriendVO의 List 선언
    lazy var list : [FriendVO] = {
        var datalist=[FriendVO]()
        return datalist
    }()
    
    
    
    
    /// viewDidLoad일때 실행되는 함수
    /// 가장 먼저 실행됨
    override func viewDidLoad() {
        self.showActivityIndicator()
        //refreshControl을 tableView에 선언하고 액션을 지정함
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.startReloadTableContents(_:)), for: UIControlEvents.valueChanged)
        
        //json을 받아오고 parsing한 뒤 추가함
        
        DispatchQueue.global().async{
            defer{
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.tableView.reloadData()
                }
            }
            do{
                self.jsonparse()
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    /// refreshControl에서 TableContents를 StartReload하는 함수
    /// 기존 리스트를 지우고 다시 json을 호출해서 테이블을 구성함
    /// - Parameter sender: UIRefreshControl을 호출
    @objc func startReloadTableContents(_ sender: UIRefreshControl) {
        list.removeAll()
        jsonparse()
        self.tableView.reloadData()
        
        //실행이 끝나면 refresh를 중지
        sender.endRefreshing()
    }
    
  /// json을 parsing하는 함수
  @objc func jsonparse(){
        //API 호출을 위한url생성
        let url = "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id"
        let apiURL : URL! = URL(string: url)

        //API를 호출
        let apidata = try! Data(contentsOf: apiURL)

        //JSON객체를 파싱하여 NSDictionary 객체로 받음
        do{
            let apiDic = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary

            //데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let results = apiDic["results"] as! NSArray

            for row in results{
                //순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary

                //테이블 뷰 리스트를 구성할 데이터 형식
                let fvo = FriendVO()
                
                //이름 파싱
                var fullName=r["name"] as? [String: String]

                let tn=fullName!["title"]!
                let fn=fullName!["first"]!
                let ln=fullName!["last"]!
                
                //이름을 합치고 첫 글자는 대문자로 변환
                fvo.name = "\(String(describing: tn)) \(String(describing: fn)) \(String(describing: ln))"
                fvo.name!=(fvo.name?.capitalized)!
                
                //이메일과 전화번호 파싱
                fvo.email = r["email"] as? String
                fvo.cellNum = r["cell"] as? String

                //id를 파싱
                var idd=r["id"] as? [String : Any]
                let name = idd!["name"] as? String
                let value = idd!["value"] as? String

                fvo.id = "\(String(describing: name)) + \(String(describing: value))"

                //이미지의 url을 파싱
                var urll = r["picture"] as? [String : Any]
                fvo.pic = urll!["thumbnail"] as? String
                fvo.largePic = urll!["large"] as? String
                
                //국가 파싱
                fvo.nat = r["nat"] as? String

                self.list.append(fvo)
            }

        } catch{

        }
    }
    
    /// 테이블 뷰 행의 개수를 반환하는 메소드를 재정의
    ///
    /// - Parameters:
    ///   - tableView: 테이블 뷰
    ///   - section: 섹션의 행 갯수
    /// - Returns: 리스트의 갯수를 리턴
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }
    
    
    /// 테이블 뷰 행을 구성하는 메소드를 재정의
    ///
    /// - Parameters:
    ///   - tableView: 테이블 뷰
    ///   - indexPath: indexPath
    /// - Returns: 커스텀 셀을 리턴
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //주어진 행에 맞는 데이터 소스를 읽어온다
        let row = self.list[indexPath.row]
        
        //테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell=tableView.dequeueReusableCell(withIdentifier: "ListCell", for : indexPath) as! FriendCell
        
        //커스텀 셀에 이름,이메일,이미지값 입력
        cell.name?.text=row.name
        cell.email?.text=row.email
        
        
        let url: URL! = URL(string: row.pic!)
        let imageData = try! Data(contentsOf: url)
        cell.pic.image = UIImage(data:imageData)

        //커스텀 셀 리턴
        return (cell)
    }
    
    /// segue를 통해 값을 전달하는 prepare함수
    ///
    /// - Parameters:
    ///   - segue: UIStoryboardSegue의 segue에 적용
    ///   - sender: Any?로 받음
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //segue의 식별자가 segue_detail일 때
        if segue.identifier == "segue_detail"{
            //첫번째 인자값을 이용하여 사용자가 몇 번째 행을 선택했는지 확인
            let path = self.tableView.indexPath(for: sender as! FriendCell)
            
            //행 정보를 통해 선택된 친구 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 fvo에 대입
            let detailFC = segue.destination as? DetailViewController
            detailFC?.fvo = self.list[path!.row]
        }
    }
    // 인디케이터 선언
    lazy var indicator: UIActivityIndicatorView={
        let indicator: UIActivityIndicatorView=UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        indicator.backgroundColor=UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints=false
        return indicator
    }()
    
    /// 인디케이터를 실행하는 함수
    func showActivityIndicator(){
        
        //인디케이터 추가
        self.view.addSubview(self.indicator)
        
        //인디케이터의 위치 설정
        let safeAreaLayoutGuide: UILayoutGuide=self.view.safeAreaLayoutGuide
        self.indicator.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor).isActive=true
        self.indicator.centerYAnchor.constraint(equalTo:safeAreaLayoutGuide.centerYAnchor).isActive=true
        
        //인디케이터 애니메이션 시작
        indicator.startAnimating()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible=true
    }
    
    
    /// 인디케이터를 없애는 함수
    func hideActivityIndicator(){
        
        //애니메이션을 멈추고 지운다.
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible=false
    }
}
