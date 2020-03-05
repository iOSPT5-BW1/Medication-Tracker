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
        print(medication?.log.count ?? 100)
    }
    
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dosesCounterLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    
    @IBAction func logDoseButtonTapped(_ sender: UIButton) {
        guard var dosesInt = medication?.dosesRemaining, dosesInt != 0 else {return}
        dosesInt -= 1
        medication?.dosesRemaining = dosesInt
        dosesCounterLabel.text = "\(dosesInt)"
        medicationController?.medications[cellIndex!.row].dosesRemaining = dosesInt
        medicationController?.medications[cellIndex!.row].log.append(Date())
        tableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let notes = notesTextView.text, !notes.isEmpty,
            let dosesInt = Int(dosesCounterLabel.text!) else {
                notesLabel.textColor = .red
                notesLabel.text = "Please enter medication details"
                return
        }
        medicationController?.updateMedication(medication: medication!, newDosesRemaining: dosesInt, newNotes: notes, newLog: medication!.log)
        medicationController?.saveToPersistentStore()
        if let parent = navigationController?.viewControllers.first as? MedicationListTableViewController {
            parent.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: -Important properties-
    
    var medicationController: MedicationController?
    var medication: Medication?
    var cellIndex: IndexPath?
    
    
    //MARK: -Important Methods-
    
    func updateViews() {
        guard let med = medication else {return}
        notesTextView.text = med.notes
        dosesCounterLabel.text = String(med.dosesRemaining)
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
            guard var medication = medication else {return}
            medication.dosesRemaining += 1
            medicationController?.deleteFromLog(for: &medication, at: indexPath.row)
            print(medication.log.count)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateViews()
        }
    }
}
