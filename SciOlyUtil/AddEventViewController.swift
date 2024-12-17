//
//  AddEventViewController.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 11/27/24.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerStack: UIStackView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var room: UITextField!
    
    var index = 0
    var meet: Meet!
    var vc: MeetDetailViewController!
    static var available = EventType.allCases
    
    override func viewDidLoad() {
        picker.delegate = self
        picker.dataSource = self
        
        AddEventViewController.available = MeetStore.getAvailable(meet: meet)
    }

    
    @IBAction func add(_ sender: UIButton) {
        if(room.text != ""){
            meet.blocks[index].events.append(Event(type: AddEventViewController.available[picker.selectedRow(inComponent: 0)], room: room.text!))
            
            if let index = AddEventViewController.available.firstIndex(of: EventType(rawValue: picker.selectedRow(inComponent: 0))!) {
                AddEventViewController.available.remove(at: index)
            }
            
            vc.refresh()
            self.dismiss(animated: true)
        }
        else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please make sure your input is valid ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(alert, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AddEventViewController.available.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return AddEventViewController.available[row].description
    }

    @IBAction func resign(_ sender: UIButton) {
        room.resignFirstResponder()
    }
}
