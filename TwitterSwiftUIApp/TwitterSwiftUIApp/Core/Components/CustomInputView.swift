//
//  CustomInputView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct CustomInputView: View {
    let imageName : String
    let placeHolderText : String
    let isSecureField : Bool 
    @Binding var text : String
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundColor(.gray)
                if isSecureField{
                    SecureField(placeHolderText,text:$text)
                }else{
                    TextField(placeHolderText, text: $text)
                }
            }
            Divider()
                .background(Color.gray)
        }
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(imageName: "envelope", placeHolderText: "Text", isSecureField: true, text: .constant(""))
    }
}
