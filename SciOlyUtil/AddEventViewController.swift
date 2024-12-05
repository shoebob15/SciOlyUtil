//
//  AddEventViewController.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 11/27/24.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerStack: UIStackView!
    @IBOutlet weak var customStack: UIStackView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var room: UITextField!
    
    var index = 0
    var meet: Meet!
    var vc: MeetDetailViewController!
    
    override func viewDidLoad() {
        picker.delegate = self
        picker.dataSource = self
    }

    @IBAction func customEvent(_ sender: UISwitch) {
        if sender.isOn {
            customStack.isHidden = false
            pickerStack.isHidden = true
        } else {
            customStack.isHidden = true
            pickerStack.isHidden = false
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        meet.blocks[index].events.append(Event(type: EventType(rawValue: picker.selectedRow(inComponent: 0))!, room: room.text!))
        vc.refresh()
        self.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return EventType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return EventType.allCases[row].description
    }

}
