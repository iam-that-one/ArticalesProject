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
    private var articles : FetchedResults<Article>
    var body: some View {
        ZStack{
            Color.green.opacity(0.50).ignoresSafeArea()
            ScrollView{
                VStack{
                    ForEach(articles){ artical in
                        VStack{
                            if artical.categoery == "Comedy"{
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
                                            delete(article: artical)
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

