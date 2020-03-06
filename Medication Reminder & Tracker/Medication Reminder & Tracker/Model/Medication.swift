//
//  Medication.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

struct Medication: Codable, Equatable {
    let name: String
    let numberOfDoses: Int
    var notes: String?
    var log: [Date]
    var dosesRemaining: Int
    
} //End of class

