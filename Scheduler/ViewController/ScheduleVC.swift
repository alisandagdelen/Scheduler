//
//  ScheduleVC.swift
//  Scheduler
//
//  Created by alisandagdelen on 17.02.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController {
    
    // MARK: Properties
    var stackView: UIStackView!
    
    var viewBeginDate: ViewTitleWithDetail!
    var viewEndDate: ViewTitleWithDetail!
    var viewFrequency: ViewTitleWithDetail!
    
    var datePickerBegin: UIDatePicker!
    var datePickerEnd: UIDatePicker!
    var pickerFrequency: UIPickerView!
    
    var scheduleViewModel: ScheduleViewModelProtocol?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillUI()
    }
    
    // MARK: Binding
    
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
            self.datePickerEnd.date = $0
        }
        
        scheduleViewModel.earliestEndDate.bind { [unowned self] in
            self.datePickerEnd.minimumDate = $0
        }
        
        scheduleViewModel.frequency.bind { [unowned self] in
            self.viewFrequency.lblDetail.text = $0.description
            self.viewEndDate.isHidden = $0 == .once ? true : false
            self.pickerFrequency.selectRow($0.rawValue, inComponent: 0, animated: true)
        }
    }
    
    // MARK: Button Actions
    
    @objc func beginDatePickerValueChanged(_ sender:UIDatePicker) {
        scheduleViewModel?.updateBeginDate(sender.date)
    }
    
    @objc func endDatePickerValueChanged(_ sender:UIDatePicker) {
        scheduleViewModel?.updateEndDate(sender.date)
    }
    
    @objc func tapBeginDate(_ sender : UITapGestureRecognizer) {
        hideAndShowWithAnimation(elementToShow: datePickerBegin, uiElementsToHide: pickerFrequency, datePickerEnd)
        
    }
    
    @objc func tapEndDate(_ sender : UITapGestureRecognizer) {
        hideAndShowWithAnimation(elementToShow: datePickerEnd, uiElementsToHide: pickerFrequency, datePickerBegin)
    }
    
    @objc func tapFrequency(_ sender : UITapGestureRecognizer) {
        hideAndShowWithAnimation(elementToShow: pickerFrequency, uiElementsToHide: datePickerBegin, datePickerEnd)
    }
    
    @objc func actClearButton(_ sender : UIButton) {
        scheduleViewModel?.clearSchedule()
        datePickerEnd.isHidden = true
    }
    
    @objc func actBackButton(_ sender: UIButton) {
        scheduleViewModel?.saveSchedule()
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: UI Animations
    func hideAndShowWithAnimation<T:UIView>( elementToShow: T, uiElementsToHide:T...) {
        for element in uiElementsToHide {
            element.alpha = 0
            element.isHidden = true
        }
        UIView.animate(withDuration: 0.1) {
            elementToShow.alpha = elementToShow.isHidden ? 1 : 0
            elementToShow.isHidden = !elementToShow.isHidden
        }
    }
}
// MARK: UIPickerView Delegate
extension ScheduleVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Frequency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let frequency = Frequency(rawValue: row)?.description else {
            fatalError("Unknown RecurrenceOption")
        }
        return frequency
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let frequency = Frequency(rawValue: row) else {
            fatalError("Unknown RecurrenceOption")
        }
        scheduleViewModel?.updateFrequency(frequency)
    }
}

// ViewController's UI created programmaticly
extension ScheduleVC {
    
    // MARK: UI Setup Methods
    
    func setupUI() {
        
        setupViews()
        setupPickers()
        setupStackView()
        hideAllPickers()
        setupConstraints()
        setupNavigationButtons()
        view.backgroundColor = UIColor.white
    }
    
    func setupViews() {
        viewBeginDate = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        viewFrequency = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        viewEndDate = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        
        let beginDateViewGesture = UITapGestureRecognizer(target: self, action:  #selector(self.tapBeginDate(_:)))
        let endDateViewGesture = UITapGestureRecognizer(target: self, action:  #selector(self.tapEndDate(_:)))
        let frequencyViewGesture = UITapGestureRecognizer(target: self, action:  #selector(self.tapFrequency(_:)))
        
        self.viewBeginDate.addGestureRecognizer(beginDateViewGesture)
        self.viewEndDate.addGestureRecognizer(endDateViewGesture)
        self.viewFrequency.addGestureRecognizer(frequencyViewGesture)
        
        viewBeginDate.lblTitle.text = "Begin:"
        viewFrequency.lblTitle.text = "Frequency:"
        viewEndDate.lblTitle.text = "End:"
    }
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [viewBeginDate, datePickerBegin, viewFrequency, pickerFrequency, viewEndDate, datePickerEnd])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        view.addSubview(stackView)
    }
    
    func setupPickers() {
        datePickerBegin = UIDatePicker()
        datePickerEnd = UIDatePicker()
        pickerFrequency = UIPickerView()
        pickerFrequency.delegate = self
        datePickerBegin.addTarget(self, action: #selector(beginDatePickerValueChanged(_:)), for: .valueChanged)
        datePickerEnd.addTarget(self, action: #selector(endDatePickerValueChanged(_:)), for: .valueChanged)
        
        datePickerBegin.datePickerMode = .date
        datePickerEnd.datePickerMode = .date
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewEndDate.heightAnchor.constraint(equalToConstant: 75),
            viewBeginDate.heightAnchor.constraint(equalToConstant: 75),
            viewFrequency.heightAnchor.constraint(equalToConstant: 75),
            datePickerBegin.heightAnchor.constraint(equalToConstant: 135),
            datePickerEnd.heightAnchor.constraint(equalToConstant: 135),
            pickerFrequency.heightAnchor.constraint(equalToConstant: 135)
            ])
    }
    
    func setupNavigationButtons() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.plain, target: self, action: #selector(actClearButton(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(actBackButton(_:)))
        

    }
    
    func hideAllPickers() {
        datePickerBegin.isHidden = true
        datePickerEnd.isHidden = true
        pickerFrequency.isHidden = true
    }
}
