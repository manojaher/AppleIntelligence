//
//  RecipeView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//
import SwiftUI
import FoundationModels

struct RecipeView: View {
    @State private var recipe: Recipe?
    @State private var isGenerating = false
    @State private var userRequest = "a quick pasta dish"

    var body: some View {
        VStack(spacing: 20) {
            TextField("What would you like to cook?", text: $userRequest)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Generate Recipe") {
                Task {
                    await generateRecipe()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(isGenerating)
            
            if isGenerating {
                ProgressView("Generating recipe...")
            }
            
            if let recipe = recipe {
                RecipeDetailView(recipe: recipe)
            }
        }
        .padding()
    }

    func generateRecipe() async {
        isGenerating = true
        defer { isGenerating = false }
        
        do {
            let session = LanguageModelSession()
            
            // Generate structured output
            let result = try await session.respond(
                to: "Create a recipe for \(userRequest)",
                generating: Recipe.self
            )
            
            recipe = result.content
        } catch {
            print("Error: \(error)")
        }
    }
}
