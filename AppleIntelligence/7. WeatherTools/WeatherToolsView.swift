//
//  WeatherToolsView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import FoundationModels

struct WeatherToolsView: View {
    @State private var city: String = "San Francisco"
    @State private var responseText: String = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter city", text: $city)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("Check Weather") {
                Task {
                    await fetchWeather()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading || city.isEmpty)
            
            if isLoading {
                ProgressView()
            }
            
            if !responseText.isEmpty {
                Text(responseText)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func fetchWeather() async {
        isLoading = true
        responseText = ""
        defer { isLoading = false }
        
        do {
            let session = LanguageModelSession(
                tools: [WeatherTool()]
            )

            let response = try await session.respond(
                to: "What's the weather like in \(city)? Should I bring an umbrella?"
            )
            
            responseText = response.content
        } catch {
            responseText = "Error: \(error.localizedDescription)"
        }
    }
}
