//
//  MeetsViewController.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 11/11/24.
//

import UIKit

class MeetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var noMeetsError: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        table.reloadData()
        
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "add" {
            let vc = segue.destination as! AddMeetViewController
            
            vc.vc = self
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MeetStore.meets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        update()
        
        MeetStore.save()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeetStore.meets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        
        cell.textLabel!.text = "\(MeetStore.meets[indexPath.row].name) - \(MeetStore.meets[indexPath.row].date.formatted(date: .abbreviated, time: .omitted))"
        
        return cell
    }
    
    func update() {
        if MeetStore.meets.count <= 0 {
            noMeetsError.isHidden = false
        } else {
            noMeetsError.isHidden = true
        }
    }


}
