//
//  CharacterView.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/10/23.
//

import SwiftUI

struct CharacterView: View {
    let show: String
    let character: Character
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                // background image
                
                Image(show.lowerNoSpaces)
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    // character image
                    Group {
                        AsyncImage(url: character.images.randomElement()) {image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                    .cornerRadius(25)
                    .padding(.top, 60)
                    .cornerRadius(25)
                    
                    // character info
                    VStack(alignment: .leading) {
                        
                        Group {
                            Text("\(character.name)")
                                .font(.largeTitle)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                        }
                        
                        Group {
                            Text("Occupations:")
                            
                            ForEach(character.occupations, id:\.self) {occupation in
                                    Text("• \(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            Text("Nickanames")
                            
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id:\.self) {nickname in
                                        Text("• \(nickname)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            
                        }
                        
                    }
                    .padding([.leading, .bottom], 40)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(show: Constants.bbName, character: Constants.previewCharacter)
    }
}
