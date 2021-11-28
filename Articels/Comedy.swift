//
//  Sport.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI
import CoreData

struct Comedy: View {
    @State var title = ""
    @State var info = ""

    @State var showEditBox = false
    @State var currentArtical = UUID()
    @State var toBeUpdateArtical = Article()
    @State var showMenu = false
   // @StateObject var viewModel = ViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Article.entity(), sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)] ,animation: .default)
    private var articles : FetchedResults<Article>
    var body: some View {
    ZStack{
        Color.green.opacity(0.50).ignoresSafeArea()
        ScrollView(showsIndicators: false){
            ForEach(articles){ article in
                VStack{
                    if article.categoery == "Comedyy"{
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
                                    if currentArtical == article.id && showMenu{
                                    HStack(spacing: 15){
                                    Button {
                                        delete(artical: article)
                                        showMenu = false
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.black)
                                    }
                                        Button {
                                            withAnimation(){
                                            showEditBox.toggle()
                                            }
                                            toBeUpdateArtical = article
                                            title = article.title ?? ""
                                            info = article.info ?? ""
                                        } label: {
                                            Image(systemName: "square.and.pencil")
                                                .foregroundColor(.black)
                                        }
                                        Button {
                                            makeArticalBooked(article: article)
                                        } label: {
                                            Image(systemName: article.isBooked ? "bookmark.fill" : "bookmark")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .padding(2)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .animation(.linear,value: 2)
                                    .transition(.move(edge: .top))
                                }
                                    Button {
                                        withAnimation{
                                        showMenu.toggle()
                                        }
                                        currentArtical = article.id!
                                    } label: {
                                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                            .padding(5)
                                            .background(.green)
                                            .shadow(color: .gray, radius: 5, x: 5, y: 5)
                                        
                                    }.offset(y: -20)

                                }
                                Spacer()
                                HStack{
                                    Image(systemName: "clock")
                                    Text(dateFormatter.string(from: article.creationDate ?? Date()))
                                 
                                    Spacer()
                                }
                                HStack{
                                Text("#comedy")
                                    .font(.caption)
                                    Spacer()
                                }
                                Image(uiImage: UIImage(data: article.image ?? Data()) ?? UIImage(named: "placeholder") ?? UIImage())                                            .resizable()
                                    .scaledToFill()
                                    .frame(width: 330, height: 150)
                                    .cornerRadius(5)

                            }.padding()
                    ).frame(width: 350, height: 280)
                        .shadow(color: .gray, radius: 5, x: 5, y: 5)
                    }
            
                }
                }
        
        }
        if showEditBox{
        Rectangle()
            .frame(width:300, height: 230)
            .foregroundColor(Color(.systemGray5))
           // .animation(.linear,value: 2)
            .transition(.move(edge: .bottom))
            .overlay(
                VStack{
                    TextField("Title",text:$title)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(5)
                        .background(Color.white)
                    TextEditor(text: $info)
                        
                    HStack{
                        Button {
                            update(article: toBeUpdateArtical)
                            withAnimation(){
                            showMenu = false
                            showEditBox = false
                            }
                        } label: {
                            Text("update")
                                .padding(5)
                                .background(Color.gray)
                        }
                        Button {
                            withAnimation(){
                            showEditBox = false
                            showMenu = false
                            }
                        } label: {
                            Text("cancel")
                                .padding(5)
                                .background(Color.gray)                                }
                    }.foregroundColor(.black)
                        .buttonStyle(AnimatedButton())

                }.padding()
            )
        }
}
        
    }
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.dateStyle = .full
        formatter.timeZone = TimeZone(secondsFromGMT: 3)
        return formatter
    }()
    func delete(artical : Article){
        viewContext.delete(artical)
        do{
            try viewContext.save()
        }catch{}
    }
    func makeArticalBooked(article: Article){
        article.isBooked.toggle()
        do{
            try viewContext.save()
        }catch let error{
            print(error)
        }
    }
    func update(article : Article){
        article.title = title
        article.info = info
        do{
       try viewContext.save()
        }catch let error{
            print(error)
        }
    }
}

struct Comedy_Previews: PreviewProvider {
    static var previews: some View {
        Comedy()
    }
}

