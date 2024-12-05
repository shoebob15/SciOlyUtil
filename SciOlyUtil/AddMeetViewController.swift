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
    @IBOutlet weak var blockLength: UIDatePicker!
    @IBOutlet weak var numBlocks: UITextField!
    
    var vc: MeetsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func add(_ sender: Any) {
        var blocks = [Block]()
        let min = Calendar.current.component(.minute, from: blockLength.date)
        
        for i in 0...Int(numBlocks.text!)! - 1 {
            blocks.append(
                Block(start: date.date + TimeInterval(min * 60 * i), end: date.date + TimeInterval(min * 60 * i) + TimeInterval(min * 60), events: [Event]()) // best code ever
            )
        }
        
        blocks.append(Block(start: Date.now, end: Date.now, events: [Event]())) // SS block
        
        print(blocks.count)
                
        MeetStore.meets.append(Meet(name: name.text!, date: date.date, blocks: blocks))
        
        vc.table.reloadData()
        
        vc.update()
        
        MeetStore.save()
        
        self.dismiss(animated: true)
    }
    

    @IBAction func resign(_ sender: Any) {
        name.resignFirstResponder()
    }
}
