//
//  AddNewMecationViewController.swift
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
        
    }
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberOfDosesTextField: UITextField!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var errorLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: -Important properties-
    var delegate: MedecationDelegate?
    
} //End of class
