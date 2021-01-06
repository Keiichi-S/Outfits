//
//  ClothingRow.swift
//  Outfits
//
//  Created by 末包啓一 on 2020/12/25.
//

import SwiftUI
import CoreData

struct ClothingRow: View {
    var categoryName: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var clothings: FetchedResults<Clothing>
    @State var addShow: Bool = false
    @State var editShow: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(categoryName)
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Spacer()
                if editShow == true {
                    Button(action: {   
                        editShow.toggle()
                    }){
                        Text("Finish")
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 15)
                    .padding(.top, 5)
                    .padding(.horizontal, 5)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10){
                    ForEach(clothings) { clothing in
                        let uiImage = UIImage(data: clothing.imageData!)!
                        ZStack(alignment: .topTrailing){
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 155, height: 155)
                                .cornerRadius(5)
                            if editShow {
                                Button(action: {
                                    viewContext.delete(clothing)
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }) {
                                    Image(systemName: "trash")
                                }
                            }
                            else {
                                Button(action: {
                                    clothing.setValue(!clothing.fitting, forKey: "fitting")
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }) {
                                    Image(systemName: clothing.fitting ? "checkmark.circle.fill": "checkmark.circle")
                                        .foregroundColor(clothing.fitting ? Color.green: Color.gray)
                                }
                            }
                        }
                    }
                }
                .contextMenu(ContextMenu(menuItems: {
                    Button(action: {
                        addShow.toggle()
                    }){
                        Label("Add Item", systemImage: "plus")
                    }
                    Button(action: {editShow.toggle()}){
                        if editShow == true {
                            Label("Edit Mode Off", systemImage: "slider.horizontal.3")
                        }
                        else {
                            Label("Edit Mode On", systemImage: "slider.horizontal.3")
                        }
                    }
                }))
            }
            .frame(height: 185)
        }
        .sheet(isPresented: $addShow){
            SaveImage(isShowActionSheet: $addShow, categoryName: categoryName)
        }
    }
}
