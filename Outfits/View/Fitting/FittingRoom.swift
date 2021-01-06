//
//  FittingRoom.swift
//  Outfits
//
//  Created by 末包啓一 on 2021/01/03.
//

import SwiftUI

struct FittingRoom: View {
    @State var selectedImage: UIImage?
    var clothings: FetchedResults<Clothing>
    @State var positions: [CGSize]
    @State var scaleValues: [CGFloat]
    @State var zValues: [Bool]
    @State private var preIndex: Int = 0
    
    
    var body: some View {
        Image(uiImage: selectedImage!)
            .resizable()
            .scaleEffect(scaleValues[0])
            .frame(width: 200, height: 200)
            .position(x: positions[0].width, y: positions[0].height)
            .gesture(DragGesture()
                        .onChanged{ value in
                            positions[0] = CGSize(
                                width: value.startLocation.x + value.translation.width,
                                height: value.startLocation.y + value.translation.height
                            )
                            zValues[preIndex] = false
                            zValues[0] = true
                            self.preIndex = 0
                        }
                        .onEnded{ value in
                            positions[0] = CGSize(
                                width: value.startLocation.x + value.translation.width,
                                height: value.startLocation.y + value.translation.height
                            )
                        }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scaleValues[0] = value
                        zValues[preIndex] = false
                        zValues[0] = true
                        self.preIndex = 0
                    }
            )
            .zIndex(zValues[0] ? 1.0 : 0.0)
        ForEach(1 ..< clothings.count + 1){ index in
            let uiImage = UIImage(data: clothings[index-1].imageData!)!
            Image(uiImage: uiImage)
                .resizable()
                .scaleEffect(scaleValues[index])
                .frame(width: 200, height: 200)
                .position(x: positions[index].width, y: positions[index].height)
                .gesture(DragGesture()
                        .onChanged{ value in
                                positions[index] = CGSize(
                                width: value.startLocation.x + value.translation.width,
                                height: value.startLocation.y + value.translation.height
                            )
                            zValues[preIndex] = false
                            zValues[index] = true
                            self.preIndex = index
                        }
                        .onEnded{ value in
                                positions[index] = CGSize(
                                width: value.startLocation.x + value.translation.width,
                                height: value.startLocation.y + value.translation.height
                            )
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scaleValues[index] = value
                            zValues[preIndex] = false
                            zValues[index] = true
                            self.preIndex = index
                        }
                )
                .zIndex(zValues[index] ? 1.0 : 0.0)
            
        }
    }
}
