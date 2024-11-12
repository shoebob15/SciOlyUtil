//
//  AddMeetViewController.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 11/11/24.
//

import UIKit

class AddMeetViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var add: UIButton!
    
    var vc: MeetsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func add(_ sender: Any) {
        MeetStore.meets.append(Meet(name: name.text!, date: date.date))
        
        vc.table.reloadData()
        
        vc.update()
        
        MeetStore.save()
        
        self.dismiss(animated: true)
    }
    

    @IBAction func resign(_ sender: Any) {
        name.resignFirstResponder()
    }
}
