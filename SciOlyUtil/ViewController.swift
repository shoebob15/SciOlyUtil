//
//  ViewController.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 10/29/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AthleteStore.load()
        MeetStore.load()
    }


}

