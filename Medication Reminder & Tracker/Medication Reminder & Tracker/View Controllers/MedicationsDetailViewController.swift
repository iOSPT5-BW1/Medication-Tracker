//
//  MedicationDetailsViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Rob Vance on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationsDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dosesCounterLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    
    @IBAction func logDoseButtonTapped(_ sender: UIButton) {
        guard var dosesInt = medication?.numberOfDoses,
            dosesInt != 0 else {
                return
        }
        dosesInt -= 1
        medication?.numberOfDoses = dosesInt
        dosesCounterLabel.text = "\(dosesInt)"
        medicationController?.medications[cellIndex!.row].numberOfDoses = dosesInt
        medicationController?.medications[cellIndex!.row].log.append(Date())
        tableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = title, !name.isEmpty,
            let notes = notesTextView.text, !notes.isEmpty,
            let numberOfDoses = dosesCounterLabel.text, !numberOfDoses.isEmpty else {
                notesLabel.textColor = .red
                notesLabel.text = "Please enter medication details"
                return
        }
        medicationController?.updateMedication(medication: medication!, name: name, numberOfDoses: Int(numberOfDoses)!, notes: notes)
        medicationController?.saveToPersistentStore()
        if let parent = navigationController?.viewControllers.first as? MedicationListTableViewController {
            parent.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    } // End of actions when the Save button is tapped
    
    
    //MARK: -Important properties-
    
    var medicationController: MedicationController?
    var medication: Medication?
    var cellIndex: IndexPath?
    
    
    //MARK: -Important Methods-
    
    func updateViews() {
        guard let med = medication else {return}
        notesTextView.text = med.notes
        dosesCounterLabel.text = String(med.numberOfDoses)
        title = med.name
        formatDateFormatter()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func formatDateFormatter() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    
    //MARK: -Important properties-
    
    let dateFormatter = DateFormatter()
    
} //End of class



extension MedicationsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        medication?.log.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogTableViewCell
        
        if let unwrappedLog = medication?.log {
            let logStatement = "Dose was taken at: \(dateFormatter.string(from: unwrappedLog[indexPath.row]))"
            cell.titleLabel.text = logStatement
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medication?.numberOfDoses -= 1
            medication?.log.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateViews()
            print(medication?.log.count)
        }
    }
    
}
