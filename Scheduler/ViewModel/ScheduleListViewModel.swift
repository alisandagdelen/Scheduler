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
    var scheduleCount: Int { get }
    func deleteSchedule(_ schedule:Schedule)
}

class ScheduleListViewModel: NSObject, ScheduleListViewModelProtocol {

    // MARK: Properties
    var schedules: [Schedule] {
        return dataService.getSchedules()
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
