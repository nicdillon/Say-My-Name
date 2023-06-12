//
//  FetchController.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/9/23.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse
    }
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseURL.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        quoteComponents?.queryItems = [quoteQueryItem]
        
        guard let fetchURL = quoteComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL) // try fetch request, get both data and response
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // test for valid response and correct data format
            throw NetworkError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data) // deserialize data
        
        return quote
    }
    
                        // underscore ("_") allows for params without naming param fetchCharacter("myParam") vs fetchCharacter(name: "myParam:)
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        var characterComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        characterComponents?.queryItems = [characterQueryItem]
        
        guard let fetchURL = characterComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
}
