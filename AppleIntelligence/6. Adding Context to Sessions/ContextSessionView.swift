//
//  ContextSessionView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import FoundationModels

struct ContextSessionView: View {
    var body: some View {
        Button("Understanding the conversation with context") {
            Task {
                try await tryLanguageModelSessionWithContext()
            }
        }
    }
    
    func tryLanguageModelSessionWithContext() async throws {
        // Multi-turn conversation with context
        let session = LanguageModelSession(instructions: "You are a fitness coach")

        // First prompt
        let response1 = try await session.respond(to: "What's a good beginner workout?")

        // Model remembers context
        let response2 = try await session.respond(to: "How many days per week should I do it?")

        // Check conversation history
        for message in session.transcript {
            print("\(message)")
        }
    }
}
