//
//  NoteGenerationApp.swift
//  FoundationModelStateView
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI

@main
struct NoteGenerationApp: App {
    @State var viewModel: NotesViewModel
    
    init() {
        let content = Self.loadNoteContent()
        let note = Note(content: content)
        _viewModel = State(initialValue: NotesViewModel(note: note))
    }
    
    var body: some Scene {
        WindowGroup {
            NoteGenerationAppView(note: $viewModel.note, viewModel: viewModel)
        }
    }
    
    static func loadNoteContent() -> String {
        guard let fileURL = Bundle.main.url(forResource: "NoteToSummarize", withExtension: "txt") else {
            return "Error: Could not find NoteToSummarize.txt in the bundle."
        }
        
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            return content
        } catch {
            return "Error loading file: \(error.localizedDescription)"
        }
    }
}
