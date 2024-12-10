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
        
        let alphabeticalAscClosure = { (action: UIAction) in
            self.sort(type: .Alphabetical_Asc)
        }
        
        let alphabeticalDesClosure = { (action: UIAction) in
            self.sort(type: .Alphabetical_Des)
        }
        
        var options = [UIMenuElement]()
        
        options.append(UIAction(title: "Alphabetical (Asc)", handler: alphabeticalAscClosure))
        
        options.append(UIAction(title: "Alphabetical (Des)", handler: alphabeticalDesClosure))
        
        sortButton.menu = UIMenu(title: "Sort", children: options)
        
        self.sort(type: .Alphabetical_Asc)
        

    }
    
    @IBAction func add(_ sender: UIButton) {
        event.athletes.append(
            AthleteStore.athletes[picker.selectedRow(inComponent: 0)]
        )
        vc.refresh()
        
        self.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AthleteStore.athletes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AthleteStore.athletes[row].name
    }
    
    func sort(type: SortType) {
        switch type {
        case .Alphabetical_Asc:
            AthleteStore.athletes = AthleteStore.athletes.sorted { $0.name < $1.name }
            break
            
        case .Alphabetical_Des:
            AthleteStore.athletes = AthleteStore.athletes.sorted { $1.name < $0.name }
        }
        
        picker.reloadComponent(0)
    }
    
    enum SortType {
        case Alphabetical_Asc
        case Alphabetical_Des
    }
    
}
