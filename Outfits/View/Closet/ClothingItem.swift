//
//  ClothingItem.swift
//  Outfits
//
//  Created by 末包啓一 on 2021/01/02.
//

import SwiftUI

struct ClothingItem: View {
    var clothing: Clothing
    @Environment(\.managedObjectContext) private var viewContext
    @State var editShow: Bool = false
    var body: some View {
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
        }
    }
}
