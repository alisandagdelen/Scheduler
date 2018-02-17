//
//  Schedule.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

enum Frequency: Int {
    case once = 0
    case daily = 1
    case weekly = 7
    case monthly = 30
    
    var description: String {
        switch self {
        case .once     : return "Once"
        case .daily    : return "Daily"
        case .weekly   : return "Weekly"
        case .monthly  : return "Monthly"
        }
    }
}

struct Schedule {
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
