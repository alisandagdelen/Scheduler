//
//  ScheduleListViewModel.swift
//  Scheduler
//
//  Created by alisandagdelen on 18.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

protocol ScheduleListViewModelProtocol {
    var schedules: [Schedule] { get }
    var sortedSchedules: [Schedule] { get }
    var scheduleCount: Int { get }
    func deleteSchedule(_ schedule:Schedule)
}

class ScheduleListViewModel: NSObject, ScheduleListViewModelProtocol {

    // MARK: Properties
    var schedules: [Schedule] {
        return dataService.getSchedules()
    }
    
    var sortedSchedules: [Schedule] {
        return schedules.sorted() { first, second in
            first.beginDate.compare(second.beginDate) == .orderedAscending
        }
    }
    
    var scheduleCount: Int {
        return schedules.count
    }
    
    private var dataService:ApiProtocol
    
    // MARK: Initializer

    init(dataService:ApiProtocol) {
        self.dataService = dataService
    }
    
    // MARK: Service methods
    
    func deleteSchedule(_ schedule: Schedule) {
        dataService.deleteSchedule(schedule)
    }
}
