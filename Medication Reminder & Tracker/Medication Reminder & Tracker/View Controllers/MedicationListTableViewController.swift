//
//  MedicationListTableViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationListTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setTheme()
        tableView.reloadData()
    }
    
    //MARK: -Important properties-
    
    let themeHelper = ThemeHelper()
    var medicationController = MedicationController()
    
    func setTheme() {
        guard let theme = themeHelper.themePreference else {return}
        if theme == "Dark" {
            self.tableView.backgroundColor = .darkGray
        } else if theme == "Green" {
            self.tableView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
    }
    
    // MARK: - Table view configuration -
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationController.medications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .medicationCellIdentifier , for: indexPath) as! MedicationTableViewCell
        cell.medication = medicationController.medications[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMedSegue" {
            let addMedVC = segue.destination as! AddMedicationViewController
            addMedVC.medicationController = medicationController
        } else if segue.identifier == "MedDetailSegue" {
            let medDetailVC = segue.destination as! MedicationsDetailViewController
            let cellIndex = tableView.indexPathForSelectedRow
            medDetailVC.medicationController = medicationController
            medDetailVC.medication = medicationController.medications[tableView.indexPathForSelectedRow!.row]
            medDetailVC.cellIndex = cellIndex
        } else if segue.identifier == "ThemesSegue" {
            if let selectThemeVC = segue.destination as? ThemeSelectionViewController {
                selectThemeVC.themeHelper = themeHelper
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: MedicationTableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medicationController.medications.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            medicationController.saveToPersistentStore()
        }
    }
    
} //End of class

