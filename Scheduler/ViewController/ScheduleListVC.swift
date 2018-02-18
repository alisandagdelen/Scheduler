//
//  ViewController.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class ScheduleListVC: UIViewController {
    // MARK: Model modify methods
    
    @IBOutlet weak var tblScheduleList: UITableView!
    
    var scheduleListViewModel: ScheduleListViewModelProtocol?
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleListViewModel = ScheduleListViewModel(dataService: DataService.shared)
        tblScheduleList.register(UINib(nibName: TCellSchedule.nibName, bundle: nil), forCellReuseIdentifier: TCellSchedule.nibName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblScheduleList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: IB Action methods
    
    @IBAction func actAddButton(_ sender: Any) {
        pushScheduleVC()
    }
    
    // MARK: Navigation methods
    
    func pushScheduleVC(schedule:Schedule? = nil) {
        let scheduleVC = ScheduleVC()
        scheduleVC.scheduleViewModel = ScheduleViewModel(schedule: schedule, dataService: DataService.shared)
        self.navigationController?.pushViewController(scheduleVC, animated: true)
    }
}

// MARK: TableView methods

extension ScheduleListVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleListViewModel?.scheduleCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TCellSchedule.nibName, for: indexPath) as! TCellSchedule
        cell.lblBeginDate.text = scheduleListViewModel?.sortedSchedules[indexPath.row].beginDate.formatted
        cell.lblEndDate.text = scheduleListViewModel?.sortedSchedules[indexPath.row].endDate.formatted
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let selectedSchedule = scheduleListViewModel?.sortedSchedules[indexPath.row] {
                scheduleListViewModel?.deleteSchedule(selectedSchedule)
                tblScheduleList.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedSchedule = scheduleListViewModel?.sortedSchedules[indexPath.row] {
            pushScheduleVC(schedule: selectedSchedule)
        }
    }
}

