//
//  Schedule.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

enum Frequency {
    case once
    case daily
    case weekly
    case monthly
}

class Schedule: NSObject {
    let id:String
    var beginDate: Date
    var endDate: Date
    var frequency: Frequency
    
    init(beginDate: Date, frequency: Frequency, endDate:Date) {
        self.id = NSUUID().uuidString
        self.beginDate = beginDate
        self.frequency = frequency
        self.endDate = frequency == .once ? beginDate : endDate
    }
}
