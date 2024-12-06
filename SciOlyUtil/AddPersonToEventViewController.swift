//
//  AddPersonToEventViewController.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 12/4/24.
//

import UIKit

class AddPersonToEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    
    var vc: EventDetailViewController!
    
    var event: Event!

    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        
        // build sort button
        
        let alphabetical = UIAction(title: "Alphabetical", handler: { (_) in {
            
        })
        
        

    }
    
    @IBAction func add(_ sender: UIButton) {
        event.athletes.append(
            AthleteStore.athletes[picker.selectedRow(inComponent: 0)]
        )
        vc.refresh()
        
        self.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return AthleteStore.athletes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AthleteStore.athletes[row].name
    }
    
    func sort(type: SortType, _: UIActionHandler) {
        
    }
    
    enum SortType {
        case Alphabetical
    }
    
}
