//
//  ContentView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import FoundationModels


enum FoundationModelState {
    case found
    case unavailable(reason: SystemLanguageModel.Availability.UnavailableReason)
    case undetermined
    
    var description: String {
        switch self {
        case .found: "Available"
        case .undetermined: "Undetermined"
        case .unavailable(let reason): "Unavailable: \(reason)"
        }
    }
}

struct FoundationModelStateView: View {
    @State var isAlertShown: Bool = false
    @State var foundationModelState: FoundationModelState = .undetermined
    
    var body: some View {
        Button("Check for Apple intelligence") {
            let model = SystemLanguageModel.default
            
            switch model.availability {
            case .available:
                foundationModelState = .found
                isAlertShown = true
            case .unavailable(let reason):
                foundationModelState = .unavailable(reason: reason)
            }
            isAlertShown = true
        }
        .alert("Foundation Models are \(foundationModelState.description)",
               isPresented: $isAlertShown) {
            Button("Okay") {}
        }
        .padding()
    }
}

#Preview {
    FoundationModelStateView()
}
