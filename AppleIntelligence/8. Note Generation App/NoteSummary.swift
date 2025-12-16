//
//  NoteSummary.swift
//  FoundationModelStateView
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import FoundationModels

@Generable
struct NoteSummary {
    @Guide(description: "Brief one-sentence summary")
    let headline: String

    @Guide(description: "Key points extracted from note")
    let keyPoints: [String]

    @Guide(description: "Action items or todos mentioned")
    let actionItems: [String]

    @Guide(description: "Sentiment of the note")
    let sentiment: Sentiment

    @Guide(description: "Suggested tags for categorization")
    let suggestedTags: [String]
}

@Generable
enum Sentiment: String {
    case positive = "Positive"
    case neutral = "Neutral"
    case negative = "Negative"
}

struct Note: Identifiable {
    let id = UUID()
    var content: String
    var aiSummary: NoteSummary?
}
