//
//  ContentView.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            Sport()
                .tabItem {
                    Text("sport")
                    Image(systemName: "sportscourt.fill")
                }
            NavigationView{
            Comedy()
            }
                .tabItem {
                    Text("Comedy")
                    Image(systemName: "command")
                }
            
            NavigationView{
        Politics()
            }
                .tabItem {
                    Text("Politics")
                    Image(systemName: "power.dotted")
                }
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManager.shared.persistentContainer
        ContentView()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}
