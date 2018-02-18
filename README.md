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



## Views

### Dependencies

There is no deppendency. No pods at all.



## Author
Alisan Dagdelen
