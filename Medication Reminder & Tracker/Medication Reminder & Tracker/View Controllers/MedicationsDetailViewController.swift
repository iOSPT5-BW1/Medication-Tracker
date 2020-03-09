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
        setTheme()
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
    
    let dateFormatter = DateFormatter()
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
        notesTextView.delegate = self as? UITextViewDelegate
        configureDoneButton()
        setTheme()
        tableView.reloadData()
    }
    
    func hideKeyboard() {
        notesTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func formatDateFormatter() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    func setTheme() {
        guard let theme = themeHelper?.themePreference else {return}
        if theme == "Dark" {
            self.tableView.backgroundColor = .darkGray
            self.view.backgroundColor = .darkGray
            notesTextView.backgroundColor = #colorLiteral(red: 0.4999483824, green: 0.50003618, blue: 0.4999368191, alpha: 1)
        } else if theme == "Green" {
            self.tableView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            self.view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            notesTextView.backgroundColor = #colorLiteral(red: 0.1508389711, green: 0.3108537793, blue: 0.3692007363, alpha: 1)
        } else if theme == "Brown" {
            self.tableView.backgroundColor = .brown
            self.view.backgroundColor = .brown
            notesTextView.backgroundColor = #colorLiteral(red: 0.5306609273, green: 0.4196858406, blue: 0.3109540045, alpha: 1)
        } else if theme == "Indigo" {
            self.tableView.backgroundColor = .systemIndigo
            self.view.backgroundColor = .systemIndigo
            notesTextView.backgroundColor = #colorLiteral(red: 0.4899598956, green: 0.5011133552, blue: 0.8346582055, alpha: 1)
        } else if theme == "none" {
            self.view.backgroundColor = #colorLiteral(red: 0.04220625013, green: 0.6572204232, blue: 0.1162761524, alpha: 1)
            self.tableView.backgroundColor = #colorLiteral(red: 0.04220625013, green: 0.6572204232, blue: 0.1162761524, alpha: 1)
            notesTextView.backgroundColor = #colorLiteral(red: 0.4119464755, green: 0.653599143, blue: 0.4092188478, alpha: 1)
        }
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    func configureDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        notesTextView.inputAccessoryView = toolbar
    }
    
} //End of class



extension MedicationsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        medication?.log.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogTableViewCell
        let theme = themeHelper?.themePreference
        if let unwrappedLog = medication?.log {
            let logStatement = "Dose was taken at: \(dateFormatter.string(from: unwrappedLog[indexPath.row]))"
            cell.titleLabel.text = logStatement
        }
        if theme == "Dark" {
            cell.backgroundColor = .darkGray
        } else if theme == "Green" {
            cell.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        } else if theme == "Brown" {
            cell.backgroundColor = .brown
        } else if theme == "Indigo" {
            cell.backgroundColor = .systemIndigo
        } else if theme == "none" {
            cell.backgroundColor = #colorLiteral(red: 0.04220625013, green: 0.6572204232, blue: 0.1162761524, alpha: 1)
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

