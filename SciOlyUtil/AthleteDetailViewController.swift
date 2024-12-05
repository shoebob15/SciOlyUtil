//
//  AthleteDetailViewController.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 11/4/24.
//

import UIKit

class AthleteDetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var name: UILabel!
    
    var athlete: Athlete = Athlete(first: "test", last: "test")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        build(athlete: athlete)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "edit" {
            let vc = segue.destination as! NewStudentViewController
            
            vc.athlete = self.athlete
            vc.edit = true
            vc.detailVc = self
            
        }
    }
    
    @IBAction func resign(_ sender: Any) {
        self.resignFirstResponder()
    }
    func build(athlete: Athlete) {
        name.text = "\(athlete.first) \(athlete.last)"
        
        var str = ""
        
        var i = 1
        for event in athlete.event {
            str.append("\(i). \(event.description)\n")
            
            i += 1
        }
        
        textView.text = str
    }
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    func refresh() {
        assert(AthleteStore.new != nil)
        self.athlete = AthleteStore.new!
        
        build(athlete: self.athlete)
    }
}
