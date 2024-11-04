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
    
    var athlete: Athlete = Athlete(first: "womp", last: "womp")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        build(athlete: athlete)
    }
    
    func build(athlete: Athlete) {
        name.text = "\(athlete.first) \(athlete.last)"
        
        var str = ""
        
        var i = 1
        for event in athlete.event {
            str.append("\(i). \(event.type.description)\n")
            
            i += 1
        }
        
        textView.text = str
    }
}
