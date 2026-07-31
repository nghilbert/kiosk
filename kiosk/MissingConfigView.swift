//
//  MissingConfigView.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/27/26.
//

import SwiftUI

struct MissingConfigView: View {
    var body: some View {
        VStack(spacing: 28) {
            Image(systemName: "gear.badge.questionmark")
                .font(.system(size: 72))
                .foregroundStyle(.gray)
            
            Text("Admin Configuration Needed")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("This kiosk is waiting to receive its URL.\nPlease configure the 'KioskURL' key in your MDM.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
