//
//  AddNewMecationViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Rob Vance on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//
import UIKit

class AddMedicationViewController: UIViewController {
    
    //MARK: -Important properties-
    
    var medicationController: MedicationController?
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberOfDosesTextField: UITextField!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var errorLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let notes = notesTextView.text, !notes.isEmpty,
            let numberOfDoses = numberOfDosesTextField.text, !numberOfDoses.isEmpty else {
                errorLabel.textColor = .red
                errorLabel.text = "Please enter medication details"
                return
        }
        guard let dosesInt = Int(numberOfDoses),
        dosesInt >= 0 else {
            errorLabel.textColor = .red
            errorLabel.text = "Please enter a valid number"
            return
        }
        medicationController?.createMedication(name: name, numberOfDoses: String(dosesInt), notes: notes)
        if let parent = navigationController?.viewControllers.first as? MedicationListTableViewController {
            parent.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    } // End of actions when the Save button is tapped
    
} //End of class
