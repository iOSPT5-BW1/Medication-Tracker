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
    var date: Date?
    
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
    
    func deleteFromLog(for medication: Medication, at logIndex: Int) -> Medication {
        guard let index = medications.firstIndex(of: medication) else { preconditionFailure("Should never get here") }
        medications[index].log.remove(at: logIndex)
        medications[index].dosesRemaining += 1
        saveToPersistentStore()
        return medications[index]
    }
    
    func addToLog(for medication: Medication) -> Medication {
        guard let index = medications.firstIndex(of: medication) else { preconditionFailure("Should never get here") }
        medications[index].log.insert(Date(), at: 0)
        medications[index].dosesRemaining -= 1
        saveToPersistentStore()
        return medications[index]
    }
    
    //MARK: -Encoding and Decoding Section-
    
    var medicationListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("MedicationList.plist")
    }
    
    var dateURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("datesList.plist")
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let medURL = medicationListURL,
        let dateURL = dateURL else {return}
        let currentDate = Date()
        do {
            let data = try encoder.encode(medications)
            let dateData = try encoder.encode(currentDate)
            try data.write(to: medURL)
            try dateData.write(to: dateURL)
        } catch {
            print("could not save meds, error code: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let medURL = medicationListURL,
        let dateURL = dateURL else {return}
        do {
            let decoder = PropertyListDecoder()
            let medData = try Data(contentsOf: medURL)
            let dateData = try Data(contentsOf: dateURL)
            let decodedMedications = try decoder.decode([Medication].self, from: medData)
            let decodedDate = try decoder.decode(Date.self, from: dateData)
            medications = decodedMedications
            date = decodedDate
        } catch {
            print("could not load meds, error code: \(error)")
        }
    }
    
    func resetDoses() {
        if Date() == date {
            for med in medications {
                var medCopy = med
                medCopy.dosesRemaining = medCopy.numberOfDoses
            }
        }
    }
    
    init() {
        loadFromPersistentStore()
        resetDoses()
    }
    
    
    // MARK: -Date formatter-
    
    let dateFormatter = DateFormatter()
    
    func formatTheFormatter() {
        dateFormatter.dateFormat = "dd"
    }
    
} //End of class

