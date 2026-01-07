# AppleIntelligence - Swift AI Demos

A sample project demonstrating various capabilities of the Apple Intelligence (Foundation Models) framework on iOS.

## Overview

This project explores the potential of on-device intelligence using Swift and SwiftUI. It covers checking for model availability, generating text, working with structured data types (like recipes), streaming responses, and integrating custom tools (like a weather checker).

## Features

### 1. Availability Check
*   **File**: `FoundationModelStateView.swift`
*   **Description**: Checks if the device supports Apple Intelligence foundation models and displays the current availability status.
*   **Key Concepts**: `SystemLanguageModel.availability`.

### 2. Basic Generation
*   **File**: `FirstAIFeatureView.swift`
*   **Description**: A simple Q&A interface where you can ask general questions and get responses from the model.
*   **Key Concepts**: `LanguageModelSession`, basic prompt response.

### 3. Structured Data Generation
*   **File**: `RecipeView.swift` (and dependencies)
*   **Description**: Generates a fully structured `Recipe` object (with ingredients, steps, etc.) based on user input.
*   **Key Concepts**: `@Generable` structs, strongly typed generation.

### 4. Streaming Responses
*   **File**: `StreamingStructuredDataView.swift`
*   **Description**: Streams a structured recipe progressively as it is being generated, providing a responsive UI with real-time feedback.
*   **Key Concepts**: `streamResponse(to:generating:)`, handling partial structured data updates.

### 5. Custom Tools
*   **File**: `WeatherToolsView.swift`
*   **Description**: Demonstrates how to give the model access to external tools. In this example, the model can "fetch" weather data for a city to answer user queries.
*   **Key Concepts**: `Tool` protocol, passing tools to `LanguageModelSession`.

## Requirements

*   **Xcode**: 16.0 or later (Beta required for Apple Intelligence features).
*   **iOS**: 18.0 or later (Beta).
*   **Device**: Device with Apple Silicon (A17 Pro or M-series) for on-device model support.

## Getting Started

1.  Open `AppleIntelligence.xcodeproj` in Xcode 16+.
2.  Ensure you have a supported device or simulator selected.
3.  Build and run the app.
4.  Navigate through the different demos to explore the features.

## Note

This project uses experimental APIs for Apple Intelligence which are subject to availability and change. Ensure your development environment is correctly set up for on-device intelligence.
