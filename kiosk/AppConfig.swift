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
    // Status of the config (Equatable allows equality operations)
    enum ConfigStatus: Equatable {
        case pending
        case configured(URL)
        case unconfigured
    }
    
    private let provider = ManagedAppConfigurationProvider()
    
    // Stores the current configuration status
    var status: ConfigStatus = .pending
    
    // Continuously listens for configuration updates streamed from the MDM provider
    func listenForMDMUpdates() async {
        // Collect configurations defined by Kiosk Configuration
        let sequence = await provider.configurations(KioskConfiguration.self)
        
        for await config in sequence {
            let newStatus: ConfigStatus
            // Add URL to status if valid
            if let validURL = config?.kioskURLOverride {
                newStatus = .configured(validURL)
            } else {
                newStatus = .unconfigured
            }

            // Only update the status if it has changed
            if self.status != newStatus {
                self.status = newStatus
            }
        }
    }
}
