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
    var earliestBeginDate: Date { get }
    var earliestEndDate: Dynamic<Date> { get }
    
    func updateBeginDate(_ beginDate:Date)
    func updateEndDate(_ endDate:Date)
    func updateFrequency(_ frequency:Frequency)
}

class ScheduleViewModel: NSObject, ScheduleViewModelProtocol {
    
    var schedule: Schedule {
        didSet {
            beginDate.value = schedule.beginDate
            endDate.value = schedule.endDate
            frequency.value = schedule.frequency
        }
    }
    
    var beginDate: Dynamic<Date>
    
    var endDate: Dynamic<Date>
    
    var frequency: Dynamic<Frequency>
    
    var earliestBeginDate: Date {
        return Date()
    }
    
    var earliestEndDate: Dynamic<Date> {
        return Dynamic(calculateEndDate(beginDate: schedule.beginDate, frequency: schedule.frequency))
    }
    
    init(schedule: Schedule? = nil, beginDate:Date, endDate:Date, frequency:Date) {
        self.schedule = schedule ?? Schedule(beginDate: Date(), frequency: .once, endDate: Date())
        self.beginDate = Dynamic(self.schedule.beginDate)
        self.endDate = Dynamic(self.schedule.endDate)
        self.frequency = Dynamic(self.schedule.frequency)
    }
    
    func updateBeginDate(_ beginDate:Date) {
        schedule.beginDate = beginDate
    }
    
    func updateEndDate(_ endDate:Date) {
        schedule.endDate = endDate
    }
    
    func updateFrequency(_ frequency:Frequency) {
        schedule.frequency = frequency
    }
    
    private func controlEndDate(beginDate:Date, frequency:Frequency) {
        if beginDate != schedule.beginDate || frequency != schedule.frequency {
            
        }
    }
    
    private func calculateEndDate(beginDate:Date, frequency:Frequency) -> Date{
        let calculatedEndDate = Calendar.current.date(byAdding: .day, value: frequency.rawValue, to: beginDate) ?? Date()
        return calculatedEndDate
    }
}
