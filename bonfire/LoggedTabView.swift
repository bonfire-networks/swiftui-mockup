//
//  LoggedTabView.swift
//  bonfire
//
//  Created by user934911 on 10/17/23.
//

import SwiftUI

struct LoggedTabView: View {
    var body: some View {
        VStack {
            TabView {
                Text("Tab 1 content")
                .tabItem {
                    Image(systemName: "house")
                }
                
                Text("Tab 1 content")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                Text("Tab 1 content")
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                Text("Tab 1 content")
                    .tabItem {
                        Image(systemName: "bell")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
        }
        .ignoresSafeArea()
    }
        
}

#Preview {
    LoggedTabView()
}
