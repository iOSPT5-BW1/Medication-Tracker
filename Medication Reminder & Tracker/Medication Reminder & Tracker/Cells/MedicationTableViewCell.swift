//
//  MedicationTableViewCell.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/27/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    
    //MARK: -IBOutlets-
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var numberOfDosesLabel: UILabel!
    
    //MARK: -Important properties-
    
    var medication: Medication? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: -UpdateViews-
    
    func updateViews() {
        guard let med = medication else {return}
        titleLabel.text = med.name
        numberOfDosesLabel.text = String(med.numberOfDoses)
    }
    
} //End of class
