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
    @IBOutlet var tableView: LogTableView!
    @IBOutlet var dosesCounterLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    
    @IBAction func addDoseButtonTapped(_ sender: UIButton) {
        guard var dosesInt = Int(medication!.numberOfDoses),
        dosesInt >= 0 else {return}
        dosesInt -= 1
        dosesCounterLabel.text = String(dosesInt)
        medicationController?.saveToPersistentStore()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = title, !name.isEmpty,
            let notes = notesTextView.text, !notes.isEmpty,
            let numberOfDoses = dosesCounterLabel.text, !numberOfDoses.isEmpty else {
                notesLabel.text = "Please enter medication details"
                return
        }
        medicationController?.updateMedication(medication: medication!, name: name, numberOfDoses: numberOfDoses, notes: notes)
        if let parent = navigationController?.viewControllers.first as? MedicationListTableViewController {
            parent.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    } // End of actions when the Save button is tapped
    
    
    
    //MARK: -Important properties-
    
    var medicationController: MedicationController?
    var medication: Medication?
    
    
    //MARK: -Important Methods-
    
    func updateViews() {
        notesLabel.text = medication?.notes
        dosesCounterLabel.text = medication?.numberOfDoses
        title = medication?.name
        tableView.reloadData()
    }
    
} //End of class
