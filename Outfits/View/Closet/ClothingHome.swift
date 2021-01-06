//
//  ClothingHome.swift
//  Outfits
//
//  Created by 末包啓一 on 2020/12/26.
//

import SwiftUI
import CoreData

struct ClothingHome: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddCategory = false
    @State private var isShowingAlert = false
    @State private var alertInput = ""
    
    @FetchRequest(
        entity: CategoryName.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryName.timestamp, ascending: true)],
        animation: .default
    ) var categories: FetchedResults<CategoryName>
    
    var body: some View {
        NavigationView {
            List {                
                ForEach(categories) { category in
                    let categoryName = category.name ?? "None"
                    ClothingRow(
                        categoryName: categoryName,
                        clothings: FetchRequest(
                            entity: Clothing.entity(),
                            sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.timestamp, ascending: true)],
                            predicate: NSPredicate(format: "category CONTAINS[C] %@", categoryName),
                            animation: .default
                    ))
                }
                .onDelete(perform: deleteItems)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Your Clothings")
            .toolbar{
                Button(action: {isShowingAlert.toggle()}) {
                    Label("Add Category", systemImage: "plus")
                }
            }
            .navigationBarItems(leading: EditButton())
            .textFieldAlert(isShowing: $isShowingAlert, text: $alertInput)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { categories[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ClothingHome_Previews: PreviewProvider {
    static var previews: some View {
        ClothingHome().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
