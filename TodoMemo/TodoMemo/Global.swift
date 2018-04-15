//
//  Global.swift
//  TodoMemo
//
//  Created by KyungYoung Heo on 2017. 10. 29..
//  Copyright © 2017년 KyungYoung Heo. All rights reserved.
//

import Foundation

//Global Variables
var dateFormatter: DateFormatter={
    let formatter: DateFormatter=DateFormatter()
    formatter.timeStyle=DateFormatter.Style.short
    formatter.dateStyle=DateFormatter.Style.long
    return formatter
}()

var todos: [TodoInfo]=[]

let didUpdateTodoListNotification: Notification.Name=Notification.Name("did update todo list")
