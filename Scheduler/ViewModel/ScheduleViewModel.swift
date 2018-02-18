//
//  ScheduleViewModel.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

protocol ScheduleViewModelProtocol {
    var beginDate: Dynamic<Date> { get }
    var endDate: Dynamic<Date> { get }
    var frequency: Dynamic<Frequency> { get }
    var earliestBeginDate: Date { get }
    var earliestEndDate: Dynamic<Date?> { get }
    
    func updateBeginDate(_ beginDate:Date)
    func updateEndDate(_ endDate:Date)
    func updateFrequency(_ frequency:Frequency)
    func clearSchedule()
    func saveSchedule()
}

class ScheduleViewModel: NSObject, ScheduleViewModelProtocol {
   
    // MARK: Properties
    var schedule: Schedule {
        didSet {
            beginDate.value = schedule.beginDate
            endDate.value = schedule.endDate
            frequency.value = schedule.frequency
            earliestEndDate.value = calculateEndDate(beginDate: schedule.beginDate, frequency: schedule.frequency)
        }
    }
    
    var beginDate: Dynamic<Date>
    var endDate: Dynamic<Date>
    var frequency: Dynamic<Frequency>
    var earliestEndDate: Dynamic<Date?>
    
    var earliestBeginDate: Date {
        return Date()
    }
    
    private var dataService:ApiProtocol

    // MARK: Initializer

    init(schedule: Schedule? = nil, dataService:ApiProtocol) {
        self.schedule = schedule ?? Schedule(beginDate: Date(), frequency: .once, endDate: Date())
        self.beginDate = Dynamic(self.schedule.beginDate)
        self.endDate = Dynamic(self.schedule.endDate)
        self.frequency = Dynamic(self.schedule.frequency)
        self.dataService = dataService
        self.earliestEndDate = Dynamic(nil)
        super.init()
        self.earliestEndDate = Dynamic(calculateEndDate(beginDate: self.schedule.beginDate, frequency: self.schedule.frequency))
    }
    
    // MARK: Model modify methods

    func updateBeginDate(_ beginDate:Date) {
        controlEndDate(beginDate: beginDate, frequency: schedule.frequency)
        schedule.beginDate = beginDate
    }
    
    func updateEndDate(_ endDate:Date) {
        schedule.endDate = endDate
    }
    
    func updateFrequency(_ frequency:Frequency) {
        controlEndDate(beginDate: schedule.beginDate, frequency: frequency)
        schedule.frequency = frequency
    }
    
    // MARK: Service methods
    
    func clearSchedule() {
        self.schedule.beginDate = Date()
        self.schedule.frequency = .once
        controlEndDate(beginDate: schedule.beginDate, frequency: schedule.frequency)
    }
    
    func saveSchedule() {
        dataService.saveSchedule(self.schedule)
    }
    
    // MARK: Control methods

    private func controlEndDate(beginDate:Date, frequency:Frequency) {
        if beginDate != schedule.beginDate || frequency != schedule.frequency {
            let possibleEndDate = calculateEndDate(beginDate: beginDate, frequency: frequency)
            if earliestBeginDate.timeIntervalSince(possibleEndDate) < 0  {
                schedule.endDate = possibleEndDate
            }
        }
    }
    
    private func calculateEndDate(beginDate:Date, frequency:Frequency) -> Date{
        let calculatedEndDate = Calendar.current.date(byAdding: .day, value: frequency.value, to: beginDate) ?? Date()
        return calculatedEndDate
    }
}
