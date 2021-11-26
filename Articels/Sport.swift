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
                    ForEach(articles){ article in
                            if article.categoery == "Sport"{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.green.opacity(0.80))
                                .overlay(
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
                                                delete(artical: article)
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
                                        Image(uiImage: UIImage(data: article.image ?? Data()) ?? UIImage(named: "placeholder") ?? UIImage())                                            .resizable()
                                            .frame(width: 350, height: 140)

                                    }.padding()
                            ).frame(width: 350, height: 280)
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
