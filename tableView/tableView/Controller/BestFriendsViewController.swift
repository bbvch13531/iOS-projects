//
//  BestFriendsViewController.swift
//  tableView
//
//  Created by KyungYoung Heo on 2017. 11. 2..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import UIKit

class BestFriendsViewController : UITableViewController{
    
    /// viewDidLoad일때 실행되는 함수
    /// 가장 먼저 실행됨
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    /// view가 appear될 때마다 실행되는 함수.
    /// tableView의 data를 reload함
    /// - Parameter animated: animated: Bool
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    /// 테이블 뷰 행의 개수를 반환하는 메소드를 재정의
    ///
    /// - Parameters:
    ///   - tableView: 테이블 뷰
    ///   - section: 섹션의 행 갯수
    /// - Returns: 리스트의 갯수를 리턴
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //리스트의 갯수를 리턴
        return bestFriends.count
    }
    
    /// 테이블 뷰 행을 구성하는 메소드를 재정의
    ///
    /// - Parameters:
    ///   - tableView: 테이블 뷰
    ///   - indexPath: indexPath
    /// - Returns: 커스텀 셀을 리턴
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 아래에 리스트를 베프로
        
        //주어진 행에 맞는 데이터 소스를 읽어온다
        let row = bestFriends[indexPath.row]
        
        //테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell=tableView.dequeueReusableCell(withIdentifier: "ListCell", for : indexPath) as! FriendCell
        
        //커스텀 셀에 이름,이메일,이미지값 입력
        cell.name?.text=row.name
        cell.email?.text=row.email
        
        let url: URL! = URL(string: row.pic!)
        let imageData = try! Data(contentsOf: url)
        cell.pic.image = UIImage(data:imageData)
        
        return (cell)
    }
    
    /// 테이블 삭제 기능
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - editingStyle: UITableViewCellEditingStyle 중 삭제 기능
    ///   - indexPath: 삭제할 TableView의 IndexPath
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            //데이터 삭제
            bestFriends.remove(at: indexPath.row)
            //테이블에서 삭제
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            // 저장함수 호출
            SaveBestFriendsList()
        }
    }
    
    /// 테이블 이동 기능
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - sourceIndexPath: 이동시킬 TableView의 IndexPath
    ///   - destinationIndexPath: 이동이 끝난 위치에 있는 TableView의 IndexPath
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //저장함수 호출
        SaveBestFriendsList()
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
            detailFC?.fvo = bestFriends[path!.row]
        }
    }
}
