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
    @IBOutlet weak var team: UISegmentedControl!
    
    var athlete: Athlete = Athlete(first: "tmp", last: "tmp")
    
    var edit = false
    
    var vc: StudentsViewController?
    
    var detailVc: AthleteDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventPicker.delegate = self
        eventPicker.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if edit {
            reload()
        } else {
            athlete = Athlete(first: "tmp", last: "tmp")
            
            reset()
        }
        
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
        athlete.event[blockPicker.selectedSegmentIndex] = EventType(rawValue: blockPicker.selectedSegmentIndex)!
    }

    @IBAction func add(_ sender: UIButton) {
        AthleteStore.new = Athlete(first: firstName.text!, last: lastName.text!, event: athlete.event, team: TeamType(rawValue: team.selectedSegmentIndex)!)
        
        if !edit {
            AthleteStore.athletes.append(AthleteStore.new!)
        } else {
            if let index = AthleteStore.athletes.firstIndex(where: { $0.first == athlete.first && $0.last == athlete.last }) {
                AthleteStore.athletes[index] = AthleteStore.new!
            }
            
            

        }
        
        if let vc {
            vc.update()
        }
        
        if let detailVc {
            detailVc.refresh()
        }
        
        AthleteStore.save()
        
        
        
        self.dismiss(animated: true)
    }
    
    @IBAction func resign(_ sender: Any) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
    }
    @IBAction func eventNumChange(_ sender: UISegmentedControl) {
        eventPicker.selectRow(athlete.event[sender.selectedSegmentIndex].index, inComponent: 0, animated: true)
        
    }
    
    func reload() {
        firstName.text = athlete.first
        lastName.text = athlete.last
        eventPicker.selectRow(athlete.event[0].index, inComponent: 0, animated: false)
        team.selectedSegmentIndex = athlete.team.rawValue
    }
    
    func reset() {
        firstName.text = ""
        lastName.text = ""
        eventPicker.selectRow(athlete.event[0].index, inComponent: 0, animated: false)
        blockPicker.selectedSegmentIndex = 0
        team.selectedSegmentIndex = 0
    }
}
