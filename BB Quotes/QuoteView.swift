//
//  QuoteView.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/9/23.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    let show: String
    @State private var isShowingCharacterView: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack {
                    VStack {
                        Spacer(minLength: 140)
                        
                        switch viewModel.status {
                            
                        case .success(let data):
                            Text("\"\(data.quote.quote)\"")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding() // default padding
                                .background(.black.opacity(0.5))
                                .cornerRadius(25)
                                .padding(.horizontal)
                                .minimumScaleFactor(0.5)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: data.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .onTapGesture {
                                    isShowingCharacterView.toggle()
                                }
                                .sheet(isPresented: $isShowingCharacterView) {
                                    CharacterView(show: show, character: data.character)
                                }
                                
                                Text(data.character.name)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .cornerRadius(80)
                            
                        case .fetching:
                            ProgressView()
                            
                        default:
                            EmptyView()
                            
                        }
                        
                        Spacer()
                    }
                    
                    Button {
                        Task { // wrap async function in syncronous area
                            await viewModel.getData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(show == Constants.bbName ? "BreakingBadGreen" : "BetterCallSaulBlue"))
                        .cornerRadius(7)
                        .shadow(color: Color(show == Constants.bbName ? "BreakingBadYellow" : "BetterCallSaulBrown"), radius: 2)
                    }
                    
                    Spacer(minLength: 180)
                }
                .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                await viewModel.getData(for: show)
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(show: Constants.bcsName)
            .preferredColorScheme(.dark)
    }
}
