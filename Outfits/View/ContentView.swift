//
//  ContentView.swift
//  Outfits
//
//  Created by 末包啓一 on 2020/12/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selection: Tab = .closet
    
    enum Tab {
        case closet
        case fit
    }
    var body: some View {
        TabView(selection: $selection){
            ClothingHome()
                .tabItem{
                    Label("Closet", systemImage: "house")
                }
                .tag(Tab.closet)
            
            TargetImage()
                .tabItem{
                    Label("Fitting", systemImage: "camera")
                }
                .tag(Tab.fit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
