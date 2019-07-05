//
//  Task.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/26/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import Foundation

struct DayTask {
    var sectionTitle: String
    var task: [Task]
}

struct Task {
    let id: String
    var isDone: Bool
    var todo: String
    var description: String
    let timeInterval: Double
}
