//
//  ContentView.swift
//  bonfire
//
//  Created by user934911 on 10/17/23.
//

import SwiftUI

struct ProfileView: View {
    @State var offset: CGFloat = 0
    @Environment(\.colorScheme) var colorScheme
    @State var titleOffset: CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 16) {
                GeometryReader{proxy -> AnyView in
                    // Header
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    return AnyView(
                        ZStack{
                            // Banner
                            Image("bg")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width , height:  minY > 0 ? 180 + minY: 180, alignment: .center)
                                .cornerRadius(0)
                                .blur(radius: blurViewOpacity())
                            
                            
                            VStack(spacing: 5) {
                                Text("Ivan Minutillo")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleTextOffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                        }
                            .clipped()
                            .frame(height: minY > 0 ? 180 + minY: nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                }
                .frame(height: 180)
                .zIndex(1)
                VStack {
                    HStack {
                        Image("bg")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 75, height: 75)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(8)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Edit")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .stroke(Color.blue)
                                )
                        })
                        
                        
                        
                    }
                    .padding(.top, -24)
                    .padding(.bottom, -20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ivan Minutillo")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("@bernini")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        
                        Text("Explore territories, Bonfire dev, Dad, wannabe tech optimist")
                        HStack {
                            Image(systemName: "link")
                                .foregroundColor(.gray)
                            Text("https://bonfirenetworks.org")
                                .font(.callout)
                            
                            
                        }
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.gray)
                            Text("Earth")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            
                            
                        }
                        .padding(.top, 4.0)
                        
                        HStack(spacing: 4){
                            HStack {
                                Text("49")
                                    .font(.callout)
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                Text("Followers")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("37")
                                    .font(.callout)
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                Text("Following")
                                    .foregroundColor(.gray)
                                    .font(.callout)
                            }
                            .padding(.leading, 8.0)
                        }
                        .padding(.top, 8.0)
                    }
                    .overlay(
                        GeometryReader{proxy -> Color in
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.titleOffset = minY
                            }
                            
                            return Color.clear
                        }
                            .frame(width: 0, height: 0)
                        ,alignment: .top
                    )
                    ProfileTabs()
                    // FEED
                    VStack(spacing: 18) {
                        ActivityView()
                        Divider()
                        ActivityView()
                        Divider()
                        ActivityView()
                        Divider()
                        ActivityView()
                    }
                    .padding(.vertical, 12)
                    }
                    .padding(.horizontal)
                
                
                
                
                
                
                
                .zIndex(-offset > 80 ? 0 : 1)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    
    func getTitleTextOffset()->CGFloat {
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    func getOffset()->CGFloat{
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale()->CGFloat{
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity()->Double{
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
}


struct ProfileTabs: View {
    @State var currentTab = "Timeline"
    @State var tabBarOffset: CGFloat = 0
    @Namespace var animation
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack(spacing: 0){
                
                    HStack(spacing: 0, content: {
                        TabButton(title: "Timeline", animation: animation, currentTab: $currentTab)
                        Spacer()
                        TabButton(title: "Posts", animation: animation, currentTab: $currentTab)
                        Spacer()
                        TabButton(title: "Boosts", animation: animation, currentTab: $currentTab)
                })
                Divider()
            }
        .padding(.top, 24)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
        .overlay(GeometryReader{reader -> Color in
            let minY = reader.frame(in: .global).minY
            
            DispatchQueue.main.async {
                self.tabBarOffset = minY
            }
            print(minY)
            return Color.clear
        }
            .frame(width: 0, height: 0), alignment: .top
            
        )
        .zIndex(1)
    }
}


struct TabButton: View {
    var title: String
    var animation: Namespace.ID
    @Binding var currentTab: String
    var body: some View {
        Button(action: {
            withAnimation{
                currentTab = title
            }
        }, label: {
            
            LazyVStack(spacing: 12, content: {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                if currentTab == title {
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                }
                else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                }
            })
        })
    }
}


#Preview {
    ProfileView()
}

struct ActivityView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading, spacing: 10, content: {
                VStack(alignment: .leading) {
                    Text("Ivan Minutillo")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("@bernini@social.coop")
                }
                
                .foregroundColor(.gray)
                Text("Bonfire native on ios yoooo!")
                    .frame(maxHeight: 100, alignment: .top)
                GeometryReader {proxy in
                    Image("bg")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: proxy.frame(in: .global).width, height: 250)
                        .cornerRadius(15)
                }
                .frame(height: 250)
            })
        })
    }
}
