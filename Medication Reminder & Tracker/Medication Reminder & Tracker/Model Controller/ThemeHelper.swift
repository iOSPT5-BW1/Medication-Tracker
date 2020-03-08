//
//  ThemeHelper.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 3/2/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class ThemeHelper {
    let themeKey: String = "ThemeKey"
    
    func setThemePreferenceToDark() {
        UserDefaults.standard.set("Dark", forKey: themeKey)
    }
    
    func setThemePreferenceToGreen() {
        UserDefaults.standard.set("Green", forKey: themeKey)
    }
    
    func setThemePreferenceToBrown() {
        UserDefaults.standard.set("Brown", forKey: themeKey)
    }
    
    func setThemePreferenceToIndigo() {
        UserDefaults.standard.set("Indigo", forKey: themeKey)
    }
    
    func setThemePreferenceToDefault() {
        UserDefaults.standard.set("none", forKey: themeKey)
    }
    
    var themePreference: String? {
        return UserDefaults.standard.string(forKey: themeKey)
    }
    
    init() {
        if themePreference == nil {
            setThemePreferenceToDark()
        }
    }
    
}
