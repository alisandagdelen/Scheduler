//
//  ViewController.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class ScheduleListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func actAddButton(_ sender: Any) {
        let scheduleVC = ScheduleVC()
        scheduleVC.scheduleViewModel = ScheduleViewModel()
        self.navigationController?.pushViewController(scheduleVC, animated: true)
    }
}

