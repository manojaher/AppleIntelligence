//
//  StreamingResponseView.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import SwiftUI
import FoundationModels

struct StreamingResponseView: View {
    @State private var question = ""
    @State private var answer = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Ask Me Anything")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Type your question", text: $question)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Get Answer") {
                Task {
                    await streamAnswer()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(question.isEmpty || isLoading)
            
            if isLoading {
                ProgressView()
            }
            
            if !answer.isEmpty {
                ScrollView {
                    Text(answer)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
    
    func streamAnswer() async {
        answer = ""
        isLoading = true
        defer { isLoading = false }

        do {
            let session = LanguageModelSession()
            let stream = session.streamResponse(to: question)
            
            for try await partialResponse in stream {
                answer = partialResponse.content
            }
        } catch {
            answer = "Error: \(error.localizedDescription)"
        }
    }
}
