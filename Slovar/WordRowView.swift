//
//  WordRowView.swift
//  Slovar
//
//  Created by Антон Уханов on 14.7.24..
//

import SwiftUI

struct WordRowView: View {
    var word: String
    var translation: String
    var body: some View {
        HStack {
            Text(word).bold()
            Spacer()
            Text(translation)
                .kerning(1)
        }.font(.system(size: 20, design: .rounded))
            .padding(.vertical)
    }
}

#Preview {
    WordRowView(word: "Test", translation: "Translation")
}
