//
//  SettingsViewController.swift
//  Medication Reminder & Tracker
//
//  Created by Rob Vance on 2/26/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//        
//        var themeHelper: ThemeHelper?
//        
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//        }
//        // Mark: IBAction
//        @IBAction func selectedDarkTheme(_ sender: Any) {
//            themeHelper?.setThemePreferenceDark()
//            dismiss(animated: true, completion: nil)
//        }
//        @IBAction func selectedGreenTheme(_ sender: Any) {
//            themeHelper?.setThemePreferenceGreen()
//            dismiss(animated: true, completion: nil)
//        }
//    }
    
//    func setTheme() {
//           guard let themeHelper = themeHelper else { return }
//           if let themePreference = themeHelper.themePreference {
//               if themePreference == "Dark" {
//                   view.backgroundColor = UIColor.darkGray
//               } else if themePreference == "Green" {
//                   view.backgroundColor = UIColor.green
//               }
//           }
//
//       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



//class ThemeHelper {
//    var themePreference: String? {
//        let themePreference = UserDefaults.standard.string(forKey: .themePreferenceKey)
//        return themePreference
//    }
//
//    init() {
//        if themePreference == nil {
//            setThemePreferenceDark()
//        }
//    }
//
//    func setThemePreferenceDark() {
//        let userDefaults = UserDefaults.standard
//        userDefaults.set("Dark", forKey: .themePreferenceKey)
//    }
//    func setThemePreferenceGreen() {
//        let userDefaults = UserDefaults.standard
//        userDefaults.set("Green", forKey: .themePreferenceKey)
//    }
//}
//extension String {
//    static var themePreferenceKey = "ThemePreferenceKey"
//}

}

