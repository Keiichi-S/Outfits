//
//  SaveImage.swift
//  Outfits
//
//  Created by 末包啓一 on 2020/12/26.
//

import Foundation

import SwiftUI

struct SaveImage: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @Binding var isShowActionSheet: Bool
    
    var categoryName: String
    
    var body: some View {
        
        VStack {
            
            if selectedImage != nil{
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 300, height: 300)
                Button("Save"){
                    self.prepareImageForSaving(image: selectedImage!, categoryName: categoryName)
                    self.isShowActionSheet.toggle()
                }
                .padding()
            }
            else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 100, height: 100)
            }

            Button("Camera"){
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            }
            .padding()
            
            Button("Photo") {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }
            .padding()
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
    
    private func addImage(imageData: Data, categoryName: String) {
        withAnimation {
            let newClothing = Clothing(context: viewContext)
            newClothing.id = UUID()
            newClothing.category = categoryName
            newClothing.imageData = imageData
            newClothing.timestamp = Date()
            newClothing.fitting = false

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
    
    private func prepareImageForSaving(image:UIImage, categoryName: String) {
            // create NSData from UIImage
        guard let imageData = image.jpegData(compressionQuality: 1) else {
                // handle failed conversion
                print("jpg error")
                return
            }

            // send to save function
        self.addImage(imageData: imageData, categoryName: categoryName)
    }
}

//struct SaveImage_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveImage(categoryName: "test").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
