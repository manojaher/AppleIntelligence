//
//  NotesViewModel.swift
//  FoundationModelStateView
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import Observation
import FoundationModels

@MainActor
@Observable
class NotesViewModel {
    var note: Note
    var isProcessing = false
    
    init(note: Note) {
        self.note = note
    }

    func summarizeNote() async {
        isProcessing = true
        defer { isProcessing = false }
        
        do {
            let session = LanguageModelSession(
                instructions: """
                You are analyzing personal notes.
                - Extract only what's explicitly written
                - Don't invent action items
                - Be concise
                """
            )
            
            let result = try await session.respond(
                to: """
                Analyze this note and provide a structured summary:
                
                \(note.content)
                """,
                generating: NoteSummary.self
            )
            
            // Update note with AI insights
            self.note.aiSummary = result.content
        } catch LanguageModelSession.GenerationError.exceededContextWindowSize(let size) {
            // Prompt + conversation history too long
            print("Context too large - try shorter messages")
        } catch LanguageModelSession.GenerationError.guardrailViolation(let voilation) {
            // Model refused to generate content
            print("Request violated content policy")
        } catch LanguageModelSession.GenerationError.unsupportedLanguageOrLocale(let context) {
            // Language not supported
            print("Try English, Spanish, French, etc.")
        } catch {
            print("Summarization error: \(error)")
        }
    }
}
