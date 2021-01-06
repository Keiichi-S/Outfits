//
//  AddCategory.swift
//  Outfits
//
//  Created by 末包啓一 on 2020/12/26.
//

import SwiftUI
import CoreData

struct AddCategory<Presenting>: View where Presenting: View {
    @Binding var categoryName: String
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isShowing: Bool
    let presenting: Presenting
    
    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
                    ZStack {
                        self.presenting
                            .disabled(isShowing)
                        VStack {
                            Text("Add new category")
                            TextField("", text: self.$categoryName)
                            Divider()
                            VStack {
                                Button(action: {
                                    if categoryName.count != 0{
                                        withAnimation {
                                            addItem()
                                            self.isShowing.toggle()
                                        }
                                    }
                                }) {
                                    Text("Add")
                                }
                                .padding(.top, 5)
                                
                                Button(action: {
                                    withAnimation {
                                        self.isShowing.toggle()
                                    }
                                }) {
                                    Text("Cancel")
                                }
                                .padding(.top, 5)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .border(Color.black, width: 2)
                        .cornerRadius(5)
                        .frame(
                            width: deviceSize.size.width*0.7,
                            height: deviceSize.size.height*0.7
                        )
                        .opacity(self.isShowing ? 1 : 0)
                        .animation(.easeIn)
                        
                    }
                }
    }
    
    private func addItem() {
        withAnimation {
            let newCategory = CategoryName(context: viewContext)
            newCategory.id = UUID()
            newCategory.name = categoryName
            newCategory.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct AddCategory_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCategory()
//    }
//}
