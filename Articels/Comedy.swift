//
//  Comedy.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI

struct Comedy: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Article.entity(), sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)] ,animation: .default)
    var articles : FetchedResults<Article>
    var body: some View {
        ZStack{
            Color.green.opacity(0.50).ignoresSafeArea()
            ScrollView{
                ForEach(articles){ article in
                    if article.categoery == "Comedy"{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.green.opacity(0.80))
                            .overlay(
                                VStack{
                                    VStack{
                                        HStack{
                                            VStack{
                                                HStack{
                                                    Text(article.title ?? "")
                                                        .fontWeight(.bold)
                                                    Spacer()
                                                }
                                                HStack{
                                                    Text(article.info ?? "")
                                                        .font(.caption)
                                                    Spacer()
                                                }
                                            }
                                            Spacer()
                                            Button {
                                                delete(article: article)
                                            } label: {
                                                Image(systemName: "trash.fill")
                                            }
                                            
                                        }
                                        Spacer()
                                        HStack{
                                            Image(systemName: "clock")
                                            Text(dateFormatter.string(from: article.creationDate ?? Date()))
                                            Spacer()
                                        }
                                    }.padding()
                                    
                                    
                                }
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
    func delete(article : Article){
        viewContext.delete(article)
        do{
            try viewContext.save()
        }catch{}
    }
}

