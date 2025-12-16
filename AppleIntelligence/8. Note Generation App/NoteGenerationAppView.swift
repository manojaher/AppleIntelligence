//
//  NoteGenerationAppView.swift
//  FoundationModelStateView
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI

struct NoteGenerationAppView: View {
    @Binding var note: Note
    var viewModel: NotesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Original note
                Text("Note")
                    .font(.headline)
                Text(note.content)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                if let summary = note.aiSummary {
                    Divider()
                    
                    // AI Summary
                    VStack(alignment: .leading, spacing: 12) {
                        Label("AI Insights", systemImage: "sparkles")
                            .font(.headline)
                        
                        // Headline
                        Text(summary.headline)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        // Key points
                        if !summary.keyPoints.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Key Points")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                ForEach(summary.keyPoints, id: \.self) { point in
                                    HStack(alignment: .top) {
                                        Image(systemName: "circle.fill")
                                            .font(.system(size: 6))
                                            .padding(.top, 6)
                                        Text(point)
                                    }
                                }
                            }
                        }
                        
                        // Action items
                        if !summary.actionItems.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Action Items")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                ForEach(summary.actionItems, id: \.self) { item in
                                    Label(item, systemImage: "checkmark.circle")
                                }
                            }
                        }
                        
                        // Tags
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(summary.suggestedTags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                } else {
                    Button("Generate AI Summary") {
                        Task {
                            await viewModel.summarizeNote()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isProcessing)
                    
                    if viewModel.isProcessing {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Note Details")
    }
}

