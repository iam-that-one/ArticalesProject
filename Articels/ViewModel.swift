//
//  ViewModel.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 26/11/2021.
//

import SwiftUI
class ViewModel : ObservableObject{
    @Published var myArticles : [Article] = []
    @Environment(\.managedObjectContext)  var viewContext
    @FetchRequest(entity: Article.entity(), sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)] ,animation: .default)
     var articles : FetchedResults<Article>
    
    func getData()->[Article]{
        myArticles = articles.map{$0}
        return myArticles
    }
     var dateFormatter: DateFormatter = {
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
