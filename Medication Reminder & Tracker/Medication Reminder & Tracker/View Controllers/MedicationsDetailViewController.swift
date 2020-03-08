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
    @IBOutlet var doseButton: UIButton!
    
    @IBAction func logDoseButtonTapped(_ sender: UIButton) {
        guard let unwrappedMed = medication else {return}
        guard unwrappedMed.dosesRemaining > 0 else {
            // add an alert controller
            return
        }
        let updatedMed = medicationController?.addToLog(for: unwrappedMed)
        medication = updatedMed
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let notes = notesTextView.text, !notes.isEmpty,
            let dosesInt = Int(dosesCounterLabel.text!) else {
                notesLabel.textColor = .red
                notesLabel.text = "Please enter some notes"
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
    var medication: Medication? {
        didSet {
            updateViews()
        }
    }
    var cellIndex: IndexPath?
    var themeHelper: ThemeHelper?
    
    
    //MARK: -Important Methods-
    
    func updateViews() {
        loadViewIfNeeded()
        guard let med = medication else {return}
        notesTextView.text = med.notes
        dosesCounterLabel.text = String(med.dosesRemaining)
        title = med.name
        formatDateFormatter()
        tableView.delegate = self
        tableView.dataSource = self
        doseButton.isEnabled = med.dosesRemaining > 0 ? true : false
        doseButton.layer.cornerRadius = 15
        setTheme()
        tableView.reloadData()
    }
    
    func formatDateFormatter() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    func setTheme() {
        guard let theme = themeHelper?.themePreference else {return}
        if theme == "Dark" {
            self.tableView.backgroundColor = .darkGray
        } else if theme == "Green" {
            self.tableView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
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
            guard let unwrappedMedication = medication else {return}
            let updatedMedication = medicationController?.deleteFromLog(for: unwrappedMedication, at: indexPath.row)
            self.medication = updatedMedication
        }
    }
}
