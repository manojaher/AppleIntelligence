//
//  RecipeDetailView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//
import SwiftUI
import FoundationModels

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Label("\(recipe.prepTime) min", systemImage: "clock")
                    Label(recipe.difficulty.rawValue, systemImage: "chart.bar")
                    Label(recipe.cuisine, systemImage: "fork.knife")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.headline)
                    
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack {
                            Image(systemName: "checkmark.circle")
                            Text(ingredient)
                        }
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.headline)
                    
                    ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .fontWeight(.semibold)
                            Text(step)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
