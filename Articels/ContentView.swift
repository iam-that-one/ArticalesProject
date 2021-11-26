//
//  ContentView.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State var addTxtffield = ""
    @State var selected = "Sport"
    @State var catecory = ["Sport","Comedy","Politcs"]
    @State var info = ""
    @State var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView{
            NavigationView{
                Sport()
                    .navigationBarItems(trailing: Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }
                                                        ))
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
            }
            .tabItem {
                Text("sport")
                Image(systemName: "sportscourt.fill")
            }
            NavigationView{
                Comedy()
                    .navigationBarItems(trailing: Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }
                                                        ))
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
            }
            .tabItem {
                Text("Comedy")
                Image(systemName: "command")
            }
            
            NavigationView{
                Politics()
                    .navigationBarItems(trailing: Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }
                                                        ))
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
            }
            .tabItem {
                Text("Politics")
                Image(systemName: "power.dotted")
            }
        }.sheet(isPresented: $showSheet) {
            ZStack{
                Color.green.opacity(0.50).ignoresSafeArea()
                
                VStack{
                    TextField("Article Title", text: $addTxtffield)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                    TextEditor(text: $info)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                    Text("Choose a ctegery")
                    Picker("Cate", selection: $selected){
                        ForEach(catecory, id: \.self){ cat in
                            Text(cat)
                        }
                    }.pickerStyle(.wheel)
                    Button {
                        let newArtical = Article(context: viewContext)
                        newArtical.title = addTxtffield
                        newArtical.info = info
                        newArtical.categoery = selected
                        newArtical.creationDate = Date()
                        
                        do{
                            try viewContext.save()
                        }catch{
                            
                        }
                        showSheet.toggle()
                    } label: {
                        Text("Create Artical")
                            .frame(width: 200, height: 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }.padding()
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
