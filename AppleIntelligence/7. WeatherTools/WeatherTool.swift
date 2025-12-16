//
//  WeatherTool.swift
//  AppleIntelligence
//
//  Created by Manoj Aher on 06/01/26.
//

import FoundationModels

struct WeatherTool: Tool {
    let name = "get_weather"
    let description = "Get the current weather for a given city."
    
    @Generable
    struct Arguments {
        @Guide(description: "City name")
        let city: String
    }
    
    func call(arguments: Arguments) async throws -> WeatherData {
        // Call your weather API
        try await fetchWeather(for: arguments.city)
    }
}

@Generable
struct WeatherData: Codable {
    @Guide(description: "Temprature in Celsius")
    let temperature: Double
    @Guide(description: "Short condition summary")
    let condition: String
    @Guide(description: "Humidity percentage")
    let humidity: Int
}

func fetchWeather(for city: String) async throws -> WeatherData {
    // Simplified - use real weather API
    return WeatherData(
        temperature: 72.5,
        condition: "Partly Cloudy",
        humidity: 65
    )
}

