//
//  ViewController.swift
//  SampleScreenSharing
//
//  Created by DenieceKenn Gozon on 6/13/23.
//

import UIKit
import GliaWidgets

class ViewController: UIViewController {
    
    @IBOutlet weak var txtListPicker: UITextField!
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet var pvList: UIPickerView!
    
    let items = ["Option 1", "Option 2", "Option 3"]
    let pickerRowHeight: CGFloat = 60
    
    let configuration = Configuration(
        authorizationMethod: .siteApiKey(
            id: "36f98ccc-0036-4025-b99a-ef63107c2fa4",
            secret: "gls_fkizGxHnS7aMg23DZ1tXcc6sGLZNqOQJapK2"),
        environment: .usa,
        site: "e81c4c25-2534-458c-a456-1196dd038f85"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    @IBAction func btnStartScreenShareClicked(_ sender: Any) {
        try? Glia.sharedInstance.configure(
            with: configuration,
            queueId: "c68fec41-b171-41e6-942f-76b1f753a463"
        ) {
            Glia.sharedInstance.callVisualizer.showVisitorCodeViewController(from: self)
        }
    }
    
    @IBAction func dpDateValueChanged(_ sender: Any) {
        txtDatePicker.text = dpDate.date.toString()
    }
    
    @objc func cancelPicker() {
        view.endEditing(true)
    }

}

extension ViewController {
    func configureTextField() {
        txtDatePicker.text = Date().toString()
        txtDatePicker.inputView = dpDate
        txtDatePicker.inputView?.backgroundColor = .white
        txtDatePicker.inputAccessoryView = createDatePickerToolbar()
        
        txtListPicker.text = items[0]
        txtListPicker.inputView = pvList
        txtListPicker.inputView?.backgroundColor = .white
        txtListPicker.inputAccessoryView = createListPickerToolbar()
    }
    
    func createDatePickerToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        let titleButton = UIBarButtonItem(title: "Select Date", style:.plain, target: self, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Done", style:.plain, target: self, action:#selector(cancelPicker))
        toolBar.setItems([titleButton, spaceButton, cancelButton], animated: false)
        return toolBar
    }
    
    func createListPickerToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        let titleButton = UIBarButtonItem(title: "Select Option", style:.plain, target: self, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Done", style:.plain, target: self, action:#selector(cancelPicker))
        toolBar.setItems([titleButton, spaceButton, cancelButton], animated: false)
        return toolBar
    }
    
    func generateOptionLabel(_ row: Int) -> UIView {
        let height:CGFloat = pickerRowHeight
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 0, width: view.frame.size.width - 20, height: height)
        label.numberOfLines = 0
        label.text = items[row]
        let parentView = UIView()
        parentView.addSubview(label)
        return parentView
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return generateOptionLabel(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerRowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtListPicker.text = items[row]
    }
}


extension Date {
    func toString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

