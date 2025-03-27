//
//  ContentView.swift
//  AllureReportDemo
//
//  Created by Maksim Stepanov on 27.03.2025.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        let locale = ProcessInfo.processInfo.environment["ALLURE_DEMO_LOCALE"] ?? "en_US"
        let n = Int(ProcessInfo.processInfo.environment["ALLURE_DEMO_N"] ?? "5") ?? 5
        
        let data = (try? getData(n: n, locale: locale)) ?? ["No items defined"]
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .accessibilityIdentifier("icon")
            
            Text(data[0]).accessibility(identifier: "timestamp")
            
            ForEach(data[1...], id: \.self) {
                Text("  - \($0)")
            }
        }
        .navigationTitle("Items")
        .padding()
    }
}

#Preview {
    ContentView()
}
