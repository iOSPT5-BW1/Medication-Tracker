//
//  MedicationListTableViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -Important properties-
    var medicationController = MedicationController()
    
    // MARK: - Table view data source -

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationController.medications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: .medicationCellIdentifier , for: indexPath) as! MedicationTableViewCell
        cell.medication = medicationController.medications[indexPath.row]
        return cell
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: MedicationTableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "MedDetailSegue" {
            let medDetailVC = segue.destination as! MedicationsDetailViewController
            medDetailVC.medicationController = medicationController
            medDetailVC.medication = medicationController.medications[tableView.indexPathForSelectedRow!.row]
        }
        
    }

} //End of class

