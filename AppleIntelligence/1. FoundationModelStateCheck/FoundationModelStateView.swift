//
//  ContentView.swift
//  AppleIntelligence
//
//  Created by CodeAnatomyByAher on 06/01/26.
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
    
    var statusColor: Color {
        switch foundationModelState {
        case .found: return .green
        case .unavailable: return .red
        case .undetermined: return .gray
        }
    }
    
    var statusIcon: String {
        switch foundationModelState {
        case .found: return "checkmark.circle.fill"
        case .unavailable: return "xmark.circle.fill"
        case .undetermined: return "questionmark.circle.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "sparkles")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.primary)
            
            VStack(spacing: 8) {
                Text("Apple Intelligence")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Check if your device supports Apple Intelligence foundation models.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            HStack(spacing: 12) {
                Image(systemName: statusIcon)
                    .foregroundStyle(statusColor)
                    .font(.title3)
                
                Text(foundationModelState.description)
                    .font(.headline)
                    .foregroundStyle(statusColor)
            }
            .padding()
            .background(statusColor.opacity(0.1))
            .cornerRadius(12)
            
            Button {
                checkAvailability()
            } label: {
                Text("Check Availability")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding(32)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
    
    private func checkAvailability() {
        let model = SystemLanguageModel.default
        
        switch model.availability {
        case .available:
            foundationModelState = .found
        case .unavailable(let reason):
            foundationModelState = .unavailable(reason: reason)
        }
    }
}

#Preview {
    FoundationModelStateView()
}
