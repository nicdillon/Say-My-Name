//
//  Character.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/9/23.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String // need to decode from snake case to camel case
}
