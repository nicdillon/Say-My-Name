//
//  ViewModel.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/9/23.
//

import Foundation
// difference between class and struct: struct is immutable, class is meant to have changing property values (class vs record)
@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success(data: (quote: Quote, character: Character))
        case failed(error: Error)
    }
    
    @Published private(set) var status: Status = .notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) { // Constructor
        self.controller = controller // set injected dependency to the local property
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            let quote = try await controller.fetchQuote(from: show)
            
            let character = try await controller.fetchCharacter(quote.character)
            
            status = .success(data: (quote, character))
        } catch {
            status = .failed(error: error)
        }
    }
}
