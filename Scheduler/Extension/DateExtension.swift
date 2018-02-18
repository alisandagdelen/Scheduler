//
//  DateExtension.swift
//  Scheduler
//
//  Created by alisandagdelen on 18.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

extension Date {
    var formatted:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        return dateFormatter.string(from: self)
    }
}
