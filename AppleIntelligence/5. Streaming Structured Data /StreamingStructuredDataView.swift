//
//  StreamingStructuredDataView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import FoundationModels

struct StreamingStructuredDataView: View {
    @State private var recipe: Recipe?
    @State private var isGenerating = false
    @State private var userRequest = "a quick pasta dish"
    private var shouldPassInstructions = false
    private let instructions = """
        You are a helpful cooking assistant for a meal planning app.
        - Keep recipes simple and healthy
        - Prefer ingredients commonly found in grocery stores
        - Always include nutritional estimates
        - Adapt recipes for dietary restrictions when mentioned
        - Use metric measurements
    """

    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(spacing: 20) {
                    TextField("What would you like to cook?", text: $userRequest)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button("Generate Recipe") {
                        Task {
                            await streamRecipe()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isGenerating)
                    
                    if let recipe = recipe {
                        RecipeDetailView(recipe: recipe)
                    }
                    
                    if isGenerating {
                        ProgressView("Generating recipe...")
                            .padding()
                    }
                    
                    Color.clear
                        .frame(height: 1)
                        .id("bottom")
                }
                .padding()
                .onChange(of: recipe) { (_, _) in
                    withAnimation {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
        }
    }
    
    func streamRecipe() async {
        recipe = nil
        isGenerating = true
        defer { isGenerating = false }

        do {
            let session = LanguageModelSession(instructions: shouldPassInstructions ? instructions: nil)
            
            let stream = session.streamResponse(
                to: "Create a recipe for \(userRequest)",
                generating: Recipe.self
            )
            
            for try await partial in stream {
                // Construct a temporary recipe from the partial data
                // We use default values for fields that haven't arrived yet
                let partialRecipe = Recipe(
                    name: partial.content.name ?? "",
                    cuisine: partial.content.cuisine ?? "",
                    ingredients: partial.content.ingredients ?? [],
                    instructions: partial.content.instructions ?? [],
                    prepTime: partial.content.prepTime ?? 0,
                    difficulty: partial.content.difficulty ?? .easy
                )
                
                self.recipe = partialRecipe
            }
            
            // Ensure we have the final complete object
            recipe = try await stream.collect().content
        } catch {
            print("Error: \(error)")
        }
    }
}

