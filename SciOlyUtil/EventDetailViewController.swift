//
//  EventDetailViewController.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 12/4/24.
//

import UIKit

class EventDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventLabel: UILabel!

    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var overlay: UIStackView!
    
    var event: Event!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self

        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "personToMeet" {
            let vc = segue.destination as! AddPersonToEventViewController
            vc.vc = self
            vc.event = self.event
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        event.athletes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = event.athletes[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            event.athletes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        refresh()
        
        AthleteStore.save()
    }
    
    func refresh() {
        if event.athletes.isEmpty {
            overlay.isHidden = false
        } else {
            overlay.isHidden = true
        }
                
        table.reloadData()
        
        MeetStore.save()
    }
    
    func configure() {
        eventLabel.text = event.type.description
        refresh()
    }
}
