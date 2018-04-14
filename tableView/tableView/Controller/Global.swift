//
//  Global.swift
//  tableView
//
//  Created by KyungYoung Heo on 2017. 11. 3..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import Foundation

var bestFriends: [FriendVO] = {
    
    do {
        let friendData: Data = try Data(contentsOf: FriendVO.FriendsDataURL())
        let decoder: PropertyListDecoder = PropertyListDecoder()
        let friend: [FriendVO]?
        
        friend = try? decoder.decode([FriendVO].self, from: friendData)
        return friend ?? []
    } catch {
        print(error.localizedDescription)
    }
    
    return []
}()

func SaveBestFriendsList() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(bestFriends)
        try data.write(to: FriendVO.FriendsDataURL())
    } catch {
        print(error.localizedDescription)
    }
}


