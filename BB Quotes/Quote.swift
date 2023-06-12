//
//  Quote.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/9/23.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let production: String
}
