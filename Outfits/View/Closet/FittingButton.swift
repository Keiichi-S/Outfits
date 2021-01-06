//
//  FittingButton.swift
//  Outfits
//
//  Created by 末包啓一 on 2021/01/03.
//

import SwiftUI

struct FittingButton: View {
    @Binding var isSet: Bool
    var body: some View {
        Button(action: {
            isSet.toggle()
        }) {
            Image(systemName: isSet ? "star.fill": "star")
                .foregroundColor(isSet ? Color.yellow: Color.gray)
        }
    }
}

struct FittingButton_Previews: PreviewProvider {
    static var previews: some View {
        FittingButton(isSet: .constant(true))
    }
}
