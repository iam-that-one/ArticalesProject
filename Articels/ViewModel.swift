//
//  ViewModel.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 26/11/2021.
//

import SwiftUI
class ViewModel : ObservableObject{
    @Published var myArticles : [Article] = []
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Article.entity(), sortDescriptors: [NSSortDescriptor(key: "creationDate", ascending: true)] ,animation: .default)
     var articles : FetchedResults<Article>
    
    init(){
        for i in articles{
            self.myArticles.append(i)
        }
        }

    
}
