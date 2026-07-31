//
//  MissingConfigView.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/27/26.
//

import SwiftUI

struct MissingConfigView: View {
    var body: some View {
        ContentUnavailableView(
            "Admin Configuration Needed",
            systemImage: "gear.badge.questionmark",
            description: Text("This kiosk is waiting to receive its URL.\nPlease configure the 'KioskURL' key in your MDM.")
        )
    }
}
