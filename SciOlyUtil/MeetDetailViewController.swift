//
//  MeetDetailViewController.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 11/26/24.
//

import UIKit

class MeetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var meetName: UILabel!
    @IBOutlet weak var blockSelector: UISegmentedControl!
    @IBOutlet weak var overlay: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var meet: Meet!
    var events: [Event]!
    
    var selectedEvent: Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTable.dataSource = self
        eventTable.delegate = self

        configure()
        
        refresh()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addEvent" {
            let vc = segue.destination as! AddEventViewController
            vc.index = blockSelector.selectedSegmentIndex
            vc.vc = self
            vc.meet = self.meet
        }
        
        if segue.identifier == "manual" {
            let vc = segue.destination as! EventDetailViewController
            
            vc.event = selectedEvent
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTable.dequeueReusableCell(withIdentifier: "meet")!
        cell.textLabel!.text = events[indexPath.row].type.description
        cell.detailTextLabel!.text = "Room: \(events[indexPath.row].room)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = events[indexPath.row]
        performSegue(withIdentifier: "manual", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            meet.blocks[blockSelector.selectedSegmentIndex].events.remove(at: indexPath.row)
        }
        
        refresh()
    }
    
    // called once when view loads
    func configure() {
        meetName.text = meet.name
        blockSelector.removeAllSegments()
        let letters = ["A", "B", "C", "D", "E", "F", "D", "H", "I", "J", "K", "L", "M", "N", "O", "P"]
        
        for (i, _) in meet.blocks.enumerated() {
            if (i == meet.blocks.count - 1) {
                break
            }
            blockSelector.insertSegment(withTitle: letters[i], at: i, animated: false)
        }
        
        blockSelector.insertSegment(withTitle: "SS", at: meet.blocks.count, animated: false)
        
        blockSelector.selectedSegmentIndex = 0
        
        events = meet.blocks[0].events
    }
    
    // called each time state is changed
    func refresh() {
        events = meet.blocks[blockSelector.selectedSegmentIndex].events
        eventTable.reloadData()
        
        let block = meet.blocks[blockSelector.selectedSegmentIndex]
        
        // date format
        let format = DateFormatter()
        
        format.dateFormat = "hh:mm a"

        
        if blockSelector.selectedSegmentIndex < meet.blocks.count - 1 {
            timeLabel.text = "\(format.string(from: block.start)) - \(format.string(from: block.end))"
        } else {
            timeLabel.text = "SELF SCHEDULE"
        }
        

        
        if events.isEmpty {
            overlay.isHidden = false
        } else {
            overlay.isHidden = true
        }
        
        MeetStore.save()
    }
    
    
    @IBAction func blockChange(_ sender: UISegmentedControl) {
        print(meet.blocks.count)
        events = meet.blocks[sender.selectedSegmentIndex].events
        refresh()
    }
}
