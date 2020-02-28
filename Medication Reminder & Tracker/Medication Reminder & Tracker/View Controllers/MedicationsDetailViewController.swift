//
//  MedicationDetailsViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Rob Vance on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationsDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var tableView: LogTableView!
    @IBOutlet var dosesCounterLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    
    @IBAction func addDoseButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
}
