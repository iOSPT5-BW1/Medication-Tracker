//
//  MedicationController.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/27/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationController {
    
    var medications: [Medication] = []
    
    
    //MARK: -Important methods-
    
    func createMedication(name: String, numberOfDoses: Int, notes: String) {
        let newMedication = Medication(name: name, numberOfDoses: numberOfDoses, notes: notes, log: [], dosesRemaining: numberOfDoses)
        medications.append(newMedication)
        saveToPersistentStore()
    }
    
    func updateMedication(medication: Medication, newDosesRemaining: Int, newNotes: String, newLog: [Date]) {
        guard let index = medications.firstIndex(of: medication) else {return}
        var medCopy = medication
        medCopy.dosesRemaining = newDosesRemaining
        medCopy.notes = newNotes
        medCopy.log = newLog
        medications.remove(at: index)
        medications.insert(medCopy, at: index)
        saveToPersistentStore()
    }
    
    func deleteMedication(med: Medication) {
        guard let index = medications.firstIndex(of: med) else {return}
        medications.remove(at: index)
        saveToPersistentStore()
    }
    
    func deleteFromLog(for medication: inout Medication, at index: Int) {
        guard let index = medications.firstIndex(of: medication) else {return}
        medication.log.remove(at: index)
        saveToPersistentStore()
    }
    
    //MARK: -Encoding and Decoding Section-
    
    var medicationListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("MedicationList.plist")
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = medicationListURL else {return}
        do {
            let data = try encoder.encode(medications)
            try data.write(to: url)
        } catch {
            print("could not save meds, error code: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = medicationListURL else {return}
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            let decodedMedications = try decoder.decode([Medication].self, from: data)
            medications = decodedMedications
        } catch {
            print("could not load meds, error code: \(error)")
        }
    }
    
    init() {
        loadFromPersistentStore()
    }
    // MARK: -End of section-
    
} //End of class
