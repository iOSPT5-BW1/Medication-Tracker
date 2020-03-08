//
//  MedicationController.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 2/27/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class MedicationController {
    
    //MARK: -Important properties-
    
    var medications: [Medication] = []
    let dateFormatter = DateFormatter()
    let lastDateKey = "lastDateKey"
    
    var currentDate: String {
        formatTheFormatter()
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var medicationListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("MedicationList.plist")
    }
    
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
    
    func formatTheFormatter() {
        dateFormatter.dateFormat = "dd"
    }
    
    func resetDoses() {
        guard currentDate != UserDefaults.standard.string(forKey: lastDateKey) else {return}
        for med in medications {
            var medCopy = med
            medCopy.dosesRemaining = medCopy.numberOfDoses
            medCopy.log = []
            medications.remove(at: medications.firstIndex(of: med)!)
            medications.insert(medCopy, at: 0)
        }
        UserDefaults.standard.set(currentDate, forKey: lastDateKey)
    }
    
    init() {
        loadFromPersistentStore()
        resetDoses()
    }
    
    //MARK: -Encoding and Decoding Section-
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let medURL = medicationListURL else {return}
        do {
            let data = try encoder.encode(medications)
            try data.write(to: medURL)
        } catch {
            print("could not save meds, error code: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        guard let medURL = medicationListURL else {return}
        do {
            let medData = try Data(contentsOf: medURL)
            let decodedMedications = try decoder.decode([Medication].self, from: medData)
            medications = decodedMedications
        } catch {
            print("could not load meds, error code: \(error)")
        }
    }
    
} //End of class

