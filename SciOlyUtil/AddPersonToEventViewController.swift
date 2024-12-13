//
//  AddPersonToEventViewController.swift
//  SciOlyUtil
//
//  Created by Brennan Reinhard on 12/4/24.
//

import UIKit

class AddPersonToEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    var vc: EventDetailViewController!
    
    var event: Event!

    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        table.allowsMultipleSelection = true
        
        
        
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
        
        for indexPath in table.indexPathsForSelectedRows! {
            let athlete = filtered[indexPath.row]
            
            event.athletes.append(athlete)
        }
 
        vc.refresh()
        
        self.dismiss(animated: true)
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
        
        🐴()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filtered = AthleteStore.athletes.filter { athlete in
            !event.athletes.contains { $0.name == athlete.name}
        }
        
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "person")!
        
        let filtered = AthleteStore.athletes.filter { athlete in
            !event.athletes.contains { $0.name == athlete.name}
        }
        
        cell.textLabel!.text = filtered[indexPath.row].name
        cell.detailTextLabel!.text = filtered[indexPath.row].team.description
        
        return cell
    }
    
    // reloads data in table view
    func 🐴() {
        let range = NSMakeRange(0, self.table.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.table.reloadSections(sections as IndexSet, with: .automatic)
    }
    
    enum SortType {
        case Alphabetical_Asc
        case Alphabetical_Des
        case teamLvl
    }
    
}
