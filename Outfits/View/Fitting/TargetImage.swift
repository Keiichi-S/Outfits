//
//  TargetImage.swift
//  Outfits
//
//  Created by 末包啓一 on 2021/01/03.
//
import Foundation
import SwiftUI

struct TargetImage: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @FetchRequest(
        entity: Clothing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.timestamp, ascending: true)],
        predicate: NSPredicate(format: "fitting = %@", NSNumber(value: true)),
        animation: .default
        ) var clothings: FetchedResults<Clothing>
    
    enum SheetType {
        case imagePick
        case fitting
    }
    @State private var currentSheet: SheetType = .imagePick
    @State private var sheetIsPresented = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedImage != nil{
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 300, height: 300)
                    Button("Fitting"){
                        self.sheetIsPresented.toggle()
                        self.currentSheet = .fitting
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
                    self.sheetIsPresented.toggle()
                    self.currentSheet = .imagePick
                }
                .padding()
                
                Button("Photo") {
                    self.sourceType = .photoLibrary
                    self.sheetIsPresented.toggle()
                    self.currentSheet = .imagePick
                }
                .padding()
            }
            .sheet(isPresented: self.$sheetIsPresented) {
                if self.currentSheet == .imagePick{
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                }
                else if self.currentSheet == .fitting{
                    FittingRoom(
                        selectedImage: selectedImage,
                        clothings: clothings,
                        positions: getPositions(count: clothings.count+1),
                        scaleValues: getScaleValues(count: clothings.count+1),
                        zValues: getZValues(count: clothings.count+1)
                    )
                }
            }
        }
    }
}

func getPositions(count: Int) -> [CGSize] {
    var positions: [CGSize] = []
    for _ in 0..<count {
        positions.append(CGSize(width: 200, height: 200))
    }
    return positions
}

func getScaleValues(count: Int) -> [CGFloat] {
    var scaleValues: [CGFloat] = []
    for _ in 0..<count {
        scaleValues.append(1.0)
    }
    return scaleValues
}

func getZValues(count: Int) -> [Bool] {
    var zValues: [Bool] = []
    zValues.append(true)
    for _ in 1..<count {
        zValues.append(false)
    }
    return zValues
}
