//
//  ScheduleViewModel.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

protocol ScheduleViewModelProtocol {
    var schedule: Schedule { get }
    var beginDate: Dynamic<Date> { get }
    var endDate: Dynamic<Date> { get }
    var frequency: Dynamic<Frequency> { get }
    
    func updateBeginDate(_ beginDate:Date)
    func updateEndDate(_ endDate:Date)
    func updateFrequency(_ frequency:Frequency)
}

class ScheduleViewModel: NSObject, ScheduleViewModelProtocol {
    var schedule: Schedule {
        didSet {
            self.beginDate.value = self.schedule.beginDate
            self.endDate.value = self.schedule.endDate
            self.frequency.value = self.schedule.frequency
        }
    }
    
    var beginDate: Dynamic<Date>
    
    var endDate: Dynamic<Date>
    
    var frequency: Dynamic<Frequency>
    
    init(schedule: Schedule? = nil, beginDate:Date, endDate:Date, frequency:Date) {
        self.schedule = schedule ?? Schedule(beginDate: Date(), frequency: .once, endDate: Date())
        self.beginDate = Dynamic(self.schedule.beginDate)
        self.endDate = Dynamic(self.schedule.endDate)
        self.frequency = Dynamic(self.schedule.frequency)
    }
    
    func updateBeginDate(_ beginDate:Date) {
        self.schedule.beginDate = beginDate
    }
    
    func updateEndDate(_ endDate:Date) {
        self.schedule.endDate = endDate
    }
    
    func updateFrequency(_ frequency:Frequency) {
        self.schedule.frequency = frequency
    }
    
    private func controlEndDate() {
        
    }
}
