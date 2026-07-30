//
//  KioskView.swift
//  kiosk
//
//  Created by Hilbert (WORK), Nathan on 7/9/26.
//

import SwiftUI
import WebKit

struct KioskView: View {
    let url: URL
    
    // Persistent web page state
    @State private var page = WebPage(configuration: .init())
    
    var body: some View {
        // Updates the view every time the url changes
        WebView(page).task(id: url) {
            page.load(URLRequest(url: url))
        }
    }
}
