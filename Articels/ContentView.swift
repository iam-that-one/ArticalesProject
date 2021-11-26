//
//  ContentView.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State var sourceType:UIImagePickerController.SourceType = .photoLibrary
    @State private var articleIimage: Image?
    @State private var articleInputImage = UIImage()
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var addTxtffield = ""
    @State var selected = "General"
    @State var categories = ["Sport","Comedyy","Politcs","General"]
    @State var info = ""
    @State var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView{
            NavigationView{
                Articles()
                    .navigationBarItems(trailing: Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }
                    ))
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
                    .sheet(isPresented: $showSheet) {
                        ZStack{
                            Color.green.opacity(0.50).ignoresSafeArea()
                            
                            VStack{
                                TextField("Article Title", text: $addTxtffield)
                                    .padding(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                                TextEditor(text: $info)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                                Button(action:{
                                    showActionSheet.toggle()
                                }){
                                    if articleIimage != nil {
                                        articleIimage!
                                            .resizable()
                                            .frame(width: 300, height: 200, alignment: .center)
                                            .padding()
                                            .background(Color(.systemGray5))
                                            .cornerRadius(5)
                                    }else{
                                        Image(systemName: "photo.artframe")
                                            .resizable()
                                            .frame(width: 300, height: 200, alignment: .center)
                                            .padding()
                                            .background(Color(.systemGray5))
                                            .cornerRadius(5)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .actionSheet(isPresented: $showActionSheet) {
                                    ActionSheet(title: Text("Choose the artical thumbnail"), message: nil, buttons:
                                                    [
                                                        .default(Text("Camera")){
                                                            showImagePicker.toggle()
                                                            sourceType = .camera
                                                        },
                                                        .default(Text("Photo library"))
                                                        {
                                                            showImagePicker.toggle()
                                                            sourceType = .photoLibrary
                                                            
                                                        },
                                                        .cancel()
                                                    ]
                                    )
                                }
                                .sheet(isPresented: $showImagePicker, onDismiss: {
                                    if articleInputImage != UIImage(){
                                        loadImage()
                                    }
                                }) { ImagePicker(sourceType: sourceType,selectedImage: self.$articleInputImage)
                                }

                                Text("Choose a category")
                                Picker("Categories", selection: $selected){
                                    ForEach(categories, id: \.self){ category in
                                        Text(category)
                                    }
                                }.pickerStyle(.wheel)
                                Button {
                                    let newArtical = Article(context: viewContext)
                                    newArtical.id = UUID()
                                    newArtical.title = addTxtffield
                                    newArtical.info = info
                                    newArtical.isBooked = false
                                    newArtical.categoery = selected
                                    newArtical.creationDate = Date()
                                    let articlepickedImage = articleInputImage.jpegData(compressionQuality: 1.0)
                                    newArtical.image = articlepickedImage
                                    do{
                                        try viewContext.save()
                                    }catch let error{
                                        print(error)
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
            .tabItem {
                Text("articles")
                Image(systemName: "note.text")
            }
            NavigationView{
                Sport()
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
            }  .tabItem {
              
                Text("sport")
                Image(systemName: "sportscourt.fill")
            }
            NavigationView{
                Comedy()
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
            }
            .tabItem {
                Text("Comedy")
                Image(systemName: "command")
            }
            
            NavigationView{
                Politics()
                    .navigationBarTitle(Text("Aricles"),displayMode: .large)
            }
            .tabItem {
                Text("Politics")
                Image(systemName: "power.dotted")
            }
        }
    }
    func loadImage() {
        articleIimage = Image(uiImage: articleInputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManager.shared.persistentContainer
        ContentView()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}
