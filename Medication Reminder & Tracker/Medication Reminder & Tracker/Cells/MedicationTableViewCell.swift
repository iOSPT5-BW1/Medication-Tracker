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
        titleLabel.text = medication?.name
        numberOfDosesLabel.text = "\(String(describing: medication?.numberOfDoses))"
    }
    
} //End of class
