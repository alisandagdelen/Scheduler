//
//  DataService.swift
//  Scheduler
//
//  Created by alisandagdelen on 18.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

var temporaryScheduleStorage:[Schedule] = []

protocol ApiProtocol {
    func getSchedules() -> [Schedule]
    func saveSchedule(_ schedule:Schedule)
    func deleteSchedule(_ schedule:Schedule)
}

class DataService: ApiProtocol {
    
    static let shared = DataService()
    
    private init() {
        
    }
    
    func getSchedules() -> [Schedule] {
        return temporaryScheduleStorage
    }
    
    func saveSchedule(_ schedule: Schedule) {
        if let index = temporaryScheduleStorage.index(where: { $0.id == schedule.id}) {
            temporaryScheduleStorage[index] = schedule
        }else {
            temporaryScheduleStorage.append(schedule)
        }
    }
    
    func deleteSchedule(_ schedule: Schedule) {
        if let index = temporaryScheduleStorage.index(where: { $0.id == schedule.id}) {
            temporaryScheduleStorage.remove(at: index)
        }
    }
}
