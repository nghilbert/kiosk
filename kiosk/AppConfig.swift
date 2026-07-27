//
//  AppConfig.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/23/26.
//

import SwiftUI
import Observation
import ManagedApp

// The configuration payload pushed down from MDM
private struct KioskConfiguration: Decodable {
    // The kiosk URL, parsed implicitly into the native URL type by Decodable
    private(set) var kioskURLOverride: URL?
    
    // Maps Swift's camelCase convention to Jamf's PascalCase convention
    enum CodingKeys: String, CodingKey {
        case kioskURLOverride = "KioskURLOverride"
    }
}

@Observable
@MainActor
final class AppConfigManager {
    private let provider = ManagedAppConfigurationProvider()
    // The active kiosk URL, observed by swiftUI views to trigger UI updates
    var activeURL: URL?
    
    // Continuously listens for configuration updates streamed from the MDM provider
    func listenForMDMUpdates() async {
        // Collect configurations defined by Kiosk Configuration
        let sequence = await provider.configurations(KioskConfiguration.self)
        
        for await config in sequence {
            let newURL = config?.kioskURLOverride
            // Only update the active URL if it has changed
            if self.activeURL != newURL {
                self.activeURL = newURL
            }
        }
    }
}
