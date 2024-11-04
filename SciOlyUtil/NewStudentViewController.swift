//
//  NewStudentViewController.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 10/30/24.
//

import UIKit

class NewStudentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var eventPicker: UIPickerView!
    @IBOutlet weak var blockPicker: UISegmentedControl!
    
    var athlete: Athlete = Athlete(first: "tmp", last: "tmp")
    
    var vc: StudentsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventPicker.delegate = self
        eventPicker.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        athlete = Athlete(first: "tmp", last: "tmp")
        
        reset()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        athlete.event[blockPicker.selectedSegmentIndex] = Event(type: EventType(rawValue: row)!, block: 0)
    }

    @IBAction func add(_ sender: UIButton) {
        AthleteStore.new = Athlete(first: firstName.text!, last: lastName.text!, event: athlete.event)
        
        
        AthleteStore.athletes.append(AthleteStore.new!)
        
        vc!.update()
        
        self.dismiss(animated: true)
    }
    
    @IBAction func eventNumChange(_ sender: UISegmentedControl) {
        eventPicker.selectRow(athlete.event[sender.selectedSegmentIndex].type.index, inComponent: 0, animated: true)
        
    }
    func reset() {
        firstName.text = ""
        lastName.text = ""
        eventPicker.selectRow(athlete.event[0].type.index, inComponent: 0, animated: false)
        blockPicker.selectedSegmentIndex = 0
    }
}
