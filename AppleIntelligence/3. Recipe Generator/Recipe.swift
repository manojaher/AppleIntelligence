//
//  Recipe.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import FoundationModels

@Generable
struct Recipe: Equatable {
    @Guide(description: "Name of the dish")
    let name: String

    @Guide(description: "Cuisine type (Italian, Mexican, etc.)")
    let cuisine: String

    @Guide(description: "List of ingredients with quantities")
    let ingredients: [String]

    @Guide(description: "Step-by-step cooking instructions")
    let instructions: [String]

    @Guide(description: "Preparation time in minutes")
    let prepTime: Int

    @Guide(description: "Difficulty level")
    let difficulty: DifficultyLevel
}

@Generable
enum DifficultyLevel: String, Equatable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

