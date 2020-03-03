//
//  ThemeHelper.swift
//  Medication Reminder & Tracker
//
//  Created by Waseem Idelbi on 3/2/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class ThemeHelper {
    let themePreferenceKey: String = "ThemeKey"
    
    func setThemePreferenceToDark() {
        UserDefaults.standard.set("Dark", forKey: themePreferenceKey)
    }
    
    func setThemePreferenceToGreen() {
        UserDefaults.standard.set("Green", forKey: themePreferenceKey)
    }
    
    var themePreference: String? {
        return UserDefaults.standard.string(forKey: themePreferenceKey)
    }
    
    init() {
        if themePreference == nil {
            setThemePreferenceToDark()
        }
    }
    
}
