//
//  View+Extension.swift
//  Outfits
//
//  Created by 末包啓一 on 2021/01/03.
//

import SwiftUI

extension View {
    func textFieldAlert(isShowing: Binding<Bool>, text: Binding<String>) -> some View {
        AddCategory(categoryName: text, isShowing: isShowing, presenting: self)
    }
}
