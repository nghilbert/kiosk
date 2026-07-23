//
//  AppConfig.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/23/26.
//

import SwiftUI
import Observation

@Observable
@MainActor
final class AppConfigManager {
    var activeURLString: String {
        // Check if Jamf has overriden the URL
        let mdmOverrideURL = UserDefaults.standard.dictionary(forKey: "com.apple.configuration.managed")?["KioskURLOverride"] as? String
        
        if let mdmOverrideURL, !mdmOverrideURL.isEmpty {
            return mdmOverrideURL
        } else {
            // Fallback to Django AV Control (test)
            return "https://davc-route-lsavt-davc02-t.apps.paas02-t.ilstu.edu/touchpad"
        }
   }
}
