//
//  ScheduleVC.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController {
    
    var viewBeginDate: ViewTitleWithDetail!
    var viewEndDate: ViewTitleWithDetail!
    var viewFrequency: ViewTitleWithDetail!
    
    var datePickerBegin: UIDatePicker!
    var datePickerEnd: UIDatePicker!
    var pickerFrequency: UIPickerView!
    
    var scheduleViewModel: ScheduleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillUI()
    }
    
    func fillUI() {
        if !isViewLoaded {
            return
        }
        
        guard let scheduleViewModel = scheduleViewModel else { return }
        
        datePickerBegin.minimumDate = scheduleViewModel.earliestBeginDate
        
        scheduleViewModel.beginDate.bind { [unowned self] in
            self.viewBeginDate.lblDetail.text = "\($0)"
        }
        
        scheduleViewModel.endDate.bind { [unowned self] in
            self.viewEndDate.lblDetail.text = "\($0)"
        }
        
        scheduleViewModel.earliestEndDate.bind { [unowned self] in
            self.datePickerEnd.minimumDate = $0
        }
        
    }
    
}

extension ScheduleVC {
    
    func setupUI() {
        
        viewBeginDate = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        viewFrequency = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        viewEndDate = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        datePickerBegin = UIDatePicker()
        datePickerEnd = UIDatePicker()
        pickerFrequency = UIPickerView()
        
        viewBeginDate.lblTitle.text = "Begin:"
        viewFrequency.lblTitle.text = "Frequency:"
        viewEndDate.lblTitle.text = "End:"
        
        let stackView = UIStackView(arrangedSubviews: [viewBeginDate, datePickerBegin, viewFrequency, pickerFrequency, viewEndDate, datePickerEnd])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        view.addSubview(stackView)
        hideAllPickers()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewEndDate.heightAnchor.constraint(equalToConstant: 75),
            viewBeginDate.heightAnchor.constraint(equalToConstant: 75),
            viewFrequency.heightAnchor.constraint(equalToConstant: 75),
            datePickerBegin.heightAnchor.constraint(equalToConstant: 135),
            datePickerEnd.heightAnchor.constraint(equalToConstant: 135),
            pickerFrequency.heightAnchor.constraint(equalToConstant: 135),
            ])
        view.backgroundColor = UIColor.white
        
    }
    
    func hideAllPickers() {
        datePickerBegin.isHidden = true
        datePickerEnd.isHidden = true
        pickerFrequency.isHidden = true
    }
}
