//
//  AddNewMecationViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Rob Vance on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//
import UIKit

class AddMedicationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDoneButton()
        setTheme()
    }
    
    //MARK: -Important properties-
    
    var themeHelper: ThemeHelper?
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
        medicationController?.createMedication(name: name, numberOfDoses: dosesInt, notes: notes)
        if let parent = navigationController?.viewControllers.first as? MedicationListTableViewController {
            parent.tableView.reloadData()
        }
        navigationController?.popViewController(animated: true)
    } // End of actions when the Save button is tapped
    
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
        nameTextField.inputAccessoryView = toolbar
        numberOfDosesTextField.inputAccessoryView = toolbar
    }
    
    func setTheme() {
        guard let theme = themeHelper?.themePreference else {return}
        if theme == "Dark" {
            self.view.backgroundColor = .darkGray
            notesTextView.backgroundColor = #colorLiteral(red: 0.4999483824, green: 0.50003618, blue: 0.4999368191, alpha: 1)
        } else if theme == "Green" {
            self.view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            notesTextView.backgroundColor = #colorLiteral(red: 0.1508389711, green: 0.3108537793, blue: 0.3692007363, alpha: 1)
        } else if theme == "Brown" {
            self.view.backgroundColor = .brown
            notesTextView.backgroundColor = #colorLiteral(red: 0.5306609273, green: 0.4196858406, blue: 0.3109540045, alpha: 1)
        } else if theme == "Indigo" {
            self.view.backgroundColor = .systemIndigo
            notesTextView.backgroundColor = #colorLiteral(red: 0.4899598956, green: 0.5011133552, blue: 0.8346582055, alpha: 1)
        } else if theme == "none" {
            self.view.backgroundColor = #colorLiteral(red: 0.04220625013, green: 0.6572204232, blue: 0.1162761524, alpha: 1)
            notesTextView.backgroundColor = #colorLiteral(red: 0.4119464755, green: 0.653599143, blue: 0.4092188478, alpha: 1)
        }
    }
    
} //End of class
