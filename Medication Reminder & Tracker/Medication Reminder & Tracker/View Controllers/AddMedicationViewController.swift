//
//  AddMedicationViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Rob Vance on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

protocol MedecationDelegate {
    func medicationWasAdded(medication: Medication)
}

class AddMedicationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    var medicationController: MedicationController?
    var medications: Medication?
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberOfDosesTextField: UITextField!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var errorLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let notes = notesTextView.text, !notes.isEmpty,
            let numberOfDoses = numberOfDosesTextField.text, !numberOfDoses.isEmpty,
            let medDoses = Int(numberOfDoses) else {
                errorLabel.text = "Error Please Enter A Valid Number"
                return
        }
        errorLabel.text = String(medDoses)
        
        if let medications = medications {
            medicationController?.updateMedication(medication: medications, name: name, numberOfDoses: medDoses, notes: notes)
        } else {
            medicationController?.createMedication(name: name, numberOfDoses: medDoses, notes: notes)
        }
        if let parent = navigationController?.viewControllers.first as? MedicationsDetailViewController {
            parent.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    }
    func updateView() {
        guard let medications = medications else { return }
        nameTextField.text =  medications.name
        notesTextView.text = medications.notes
//        numberOfDosesTextField.text = medications.numberOfDoses
        
    }
    
    
    
    
    

    //MARK: -Important properties-
    var delegate: MedecationDelegate?
    
} //End of class


// !numberOfDoses.isEmpty,
