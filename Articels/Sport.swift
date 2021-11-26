//
//  Sport.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI
import CoreData
struct Sport: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Article.entity(), sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)] ,animation: .default)
    private var articles : FetchedResults<Article>
    var body: some View {
            ZStack{
                Color.green.opacity(0.50).ignoresSafeArea()
                ScrollView{
                    ForEach(articles){ artical in
                            if artical.categoery == "Sport"{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.green.opacity(0.80))
                                .overlay(
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
                                        
                            ).frame(width: 350, height: 140)
                                .shadow(color: .gray, radius: 5, x: 5, y: 5)
                            }
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
