//
//  Sport.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI
import CoreData
struct Sport: View {
    @State var addTxtffield = ""
    @State var select = "Sport"
    @State var catecory = ["Sport","Comedy","Politcs"]
    @State var info = ""
    @State var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Article.entity(), sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)] ,animation: .default)
    private var articles : FetchedResults<Article>
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.opacity(0.50).ignoresSafeArea()
                ScrollView{
                    VStack{
                        ForEach(articles){ artical in
                            VStack{
                                if artical.categoery == "Sport"{
                                    VStack{
                                        HStack{
                                            VStack{
                                                HStack{
                                                    Text(artical.title ?? "")
                                                        .fontWeight(.bold)
                                                    Spacer()
                                                }
                                                HStack{
                                                    Text(artical.info ?? "")
                                                        .font(.caption)
                                                    Spacer()
                                                }
                                            }
                                            Spacer()
                                            Button {
                                                delete(artical: artical)
                                            } label: {
                                                Image(systemName: "trash.fill")
                                            }
                                            
                                        }
                                        Spacer()
                                        HStack{
                                            Image(systemName: "clock")
                                            Text(dateFormatter.string(from: artical.creationDate ?? Date()))
                                            Spacer()
                                        }
                                    }.padding()
                                }
                                
                            }
                        }
                    }
                    
                    
                }
                
                
                
                .navigationBarItems(trailing: Button(action: {
                    showSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                }
            ))
                
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
                        Picker("Cate", selection: $select){
                            ForEach(catecory, id: \.self){ cat in
                                Text(cat)
                            }
                        }.pickerStyle(.wheel)
                        Button {
                            let newArtical = Article(context: viewContext)
                            newArtical.title = addTxtffield
                            newArtical.info = info
                            newArtical.categoery = select
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
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 3)
        return formatter
    }()
    func delete(artical : Article){
        viewContext.delete(artical)
        do{
            try viewContext.save()
        }catch{}
    }
}

struct Sport_Previews: PreviewProvider {
    static var previews: some View {
        Sport()
    }
}
