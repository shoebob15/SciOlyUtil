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
        
        let teamClosure = { (action: UIAction) in
            self.sort(type: .teamLvl)
        }
        
        var options = [UIMenuElement]()
        
        options.append(UIAction(title: "Alphabetical (Asc)", handler: alphabeticalAscClosure))
        
        options.append(UIAction(title: "Alphabetical (Des)", handler: alphabeticalDesClosure))
        
        options.append(UIAction(title: "Team", handler: teamClosure))
        
        sortButton.menu = UIMenu(title: "Sort", children: options)
        
        self.sort(type: .Alphabetical_Asc)
        

    }
    
    @IBAction func add(_ sender: UIButton) {
        let filtered = AthleteStore.athletes.filter { athlete in
            !event.athletes.contains { $0.name == athlete.name}
        }
        
        event.athletes.append(
            filtered[picker.selectedRow(inComponent: 0)]
        )
        vc.refresh()
        
        self.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let filtered = AthleteStore.athletes.filter { athlete in
            !event.athletes.contains { $0.name == athlete.name}
        }
        
        return filtered.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let filtered = AthleteStore.athletes.filter { athlete in
            !event.athletes.contains { $0.name == athlete.name}
        }
        
        return filtered[row].name
    }
    
    func sort(type: SortType) {
        switch type {
        case .Alphabetical_Asc:
            AthleteStore.athletes = AthleteStore.athletes.sorted { $0.name < $1.name }
            break
            
        case .Alphabetical_Des:
            AthleteStore.athletes = AthleteStore.athletes.sorted { $1.name < $0.name }
        case .teamLvl:
            AthleteStore.athletes = AthleteStore.athletes.sorted{ $0.team.rawValue < $1.team.rawValue }
        }
        
        picker.reloadComponent(0)
    }
    
    enum SortType {
        case Alphabetical_Asc
        case Alphabetical_Des
        case teamLvl
    }
    
}
