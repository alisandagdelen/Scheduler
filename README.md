# Scheduler



## Notify
Object boxing used for notify the UI elements when values changed. Assigning new value to value property triggers property observer.

``` swift
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}

```
Binding in UIViewController

``` swift
func fillUI() {
  ...
  scheduleViewModel.beginDate.bind { [unowned self] in
            self.viewBeginDate.lblDetail.text = $0.formatted
  ...
}
@objc func beginDatePickerValueChanged(_ sender:UIDatePicker) {
        scheduleViewModel?.updateBeginDate(sender.date)
}
```

## Structure

For dealing with spaghetti code Model-View-ViewModel (MVVM) design pattern used for structure. Schedule rules logics, data preparation code for visual presentation, and code listening for Model changes written in ViewModels.
For dependency injection and easier testability most of the classes created protocol oriented. Also take the models, dataServices in init methods to avoid from dependencies

``` swift
protocol ScheduleViewModelProtocol {
    var beginDate: Dynamic<Date> { get }
    var endDate: Dynamic<Date> { get }
    var frequency: Dynamic<Frequency> { get }
    var earliestBeginDate: Date { get }
    var earliestEndDate: Dynamic<Date?> { get }
    
    func updateBeginDate(_ beginDate:Date)
    ...
}
``` 
``` swift
init(schedule: Schedule? = nil, dataService:ApiProtocol) {
    ...
}
```
## Views
Diffrent methods used for UI like storyboard ,xib files and programmatic ui. In overview page storyboard and custom cell xib used.
In the schedule page ui created with xib files and mostly programmatically. UIStackView used for dynamic ui changes and ui changes made with animations in generic ui update method.

``` swift
  func hideAndShowWithAnimation<T:UIView>( elementToShow: T, uiElementsToHide:T...) {
    ...
    UIView.animate(withDuration: 0.1) {
    ...
}
```
``` swift
  func setupUI() {
        
        setupViews()
        setupPickers()
        setupStackView()
        hideAllPickers()
        ...
  }
  
 func setupViews() {
        viewBeginDate = ViewTitleWithDetail.fromNib as! ViewTitleWithDetail
        ...
 }
```

### Storage
Assignment do not have any dask about storage.So in order not to create unnecessary cost, I stored data in global array and simulated in data service.
### Dependencies

There is no deppendency. No pods at all.

### Author
Alisan Dagdelen
alisandagdelen@gmail.com
