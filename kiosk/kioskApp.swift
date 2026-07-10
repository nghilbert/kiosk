//
//  kioskApp.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/9/26.
//

import SwiftUI

@main
struct kioskApp: App {
    var body: some Scene {
        WindowGroup {
        KioskView(url: URL(string: "https://davc-route-lsavt-davc02-t.apps.paas02-t.ilstu.edu/touchpad")!).ignoresSafeArea().statusBarHidden(true)
        }
    }
}
