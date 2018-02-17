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
    
    func updateEndDate()
    func updateBeginDate()
    func updateFrequency()
}


