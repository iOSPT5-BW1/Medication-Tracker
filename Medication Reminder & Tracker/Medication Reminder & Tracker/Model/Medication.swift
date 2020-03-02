//
//  Medication.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

struct Medication: Codable, Equatable {
    var name: String
    var numberOfDoses: String
    var notes: String?
    var log: [Date]?
    
} //End of class

