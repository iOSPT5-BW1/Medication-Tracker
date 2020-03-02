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
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        guard var dosesInt = Int(medication!.numberOfDoses),
            dosesInt != 0 else {return}
        dosesInt -= 1
        medication?.numberOfDoses = String(dosesInt)
        dosesCounterLabel.text = String(dosesInt)
        medicationController?.medications[cellIndex!.row].numberOfDoses = String(dosesInt)
        medicationController?.medications[cellIndex!.row].log?.append(Date())
        medicationController?.saveToPersistentStore()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard var dosesInt = Int(medication!.numberOfDoses) else {return}
        dosesInt += 1
        medication?.numberOfDoses = String(dosesInt)
        dosesCounterLabel.text = String(dosesInt)
        medicationController?.medications[cellIndex!.row].numberOfDoses = String(dosesInt)
        medicationController?.medications[cellIndex!.row].log?.append(Date())
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
        notesTextView.text = medication?.notes
        dosesCounterLabel.text = medication?.numberOfDoses
        title = medication?.name
        // TableViewSetup
        tableView.numberOfRows(inSection: (medication?.log!.count)!)
        tableView.dequeueReusableCell(withIdentifier: "LogCell")
        
        //TableViewSetup
        tableView.reloadData()
    }
    
    
    
} //End of class
