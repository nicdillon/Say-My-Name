//
//  ContentView.swift
//  BB Quotes
//
//  Created by Nic Dillon on 6/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{ // Each view is its own screen
            QuoteView(show: Constants.bbName)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            
            QuoteView(show: Constants.bcsName)
                .tabItem {
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
