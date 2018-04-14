//
//  FriendVO.swift
//  tableView
//
//  Created by KyungYoung Heo on 2017. 10. 30..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//


import Foundation

class FriendVO: Codable{
    
    var name: String?
    var email: String?
    var id : String?
    var cellNum: String?
    var nat: String?
    var pic: String?
    var largePic: String?
    
    static func FriendsDataURL() throws -> URL {
        let fileManager = FileManager.default
        let documentURL: URL
        let FriendsURL: URL
        
        documentURL = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory,
                                          in: FileManager.SearchPathDomainMask.userDomainMask,
                                          appropriateFor: nil, create: false)
        FriendsURL = documentURL.appendingPathComponent("Friend.plist")
        return FriendsURL
    }
}

