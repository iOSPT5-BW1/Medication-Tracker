//
//  ThemeSelectionViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 3/2/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class ThemeSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var themeHelper: ThemeHelper?
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func darkButtonTapped(_ sender: UIButton) {
        themeHelper?.setThemePreferenceToDark()
        dismiss(animated: true)
    }
    
    @IBAction func greenButtonTapped(_ sender: UIButton) {
        themeHelper?.setThemePreferenceToGreen()
        dismiss(animated: true)
    }
    
    @IBAction func IndigoButtonTapped(_ sender: UIButton) {
        themeHelper?.setThemePreferenceToIndigo()
        dismiss(animated: true)
    }
    
    @IBAction func browbButtonTapped(_ sender: UIButton) {
        themeHelper?.setThemePreferenceToBrown()
        dismiss(animated: true)
    }
    
    @IBAction func noneButtonTapped(_ sender: UIButton) {
        themeHelper?.setThemePreferenceToDefault()
        dismiss(animated: true)
    }
    
}
