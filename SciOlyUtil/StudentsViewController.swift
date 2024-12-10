//
//  StudentsViewController.swift
//  SciOlyUtil
//
//  Created by BRENNAN REINHARD on 10/30/24.
//

import UIKit

class StudentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var noAthletesError: UIStackView!
    
    
    @IBOutlet weak var table: UITableView!
    
    var tmp: Athlete = Athlete(first: "tmp", last: "tmp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
        
        if AthleteStore.athletes.count <= 0 {
            noAthletesError.isHidden = false
        } else {
            noAthletesError.isHidden = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addStudent" {
            let vc = segue.destination as! NewStudentViewController
            
            vc.vc = self
        } else if segue.identifier == "detail" {
            let vc = segue.destination as! AthleteDetailViewController
            
            vc.athlete = tmp
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AthleteStore.athletes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "StudentCell")!
        
        cell.textLabel!.text = "\(AthleteStore.athletes[indexPath.row].name)"
        
        cell.detailTextLabel!.text = "\(AthleteStore.athletes[indexPath.row].team.description)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tmp = AthleteStore.athletes[indexPath.row]
        
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AthleteStore.athletes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        update()
        
        AthleteStore.save()
    }
    
    func update() {
        table.reloadData()
        
        if AthleteStore.athletes.count <= 0 {
            noAthletesError.isHidden = false
        } else {
            noAthletesError.isHidden = true
        }
        
    }
        

}
