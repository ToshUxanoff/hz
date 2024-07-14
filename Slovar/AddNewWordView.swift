//
//  AddNewWordView.swift
//  Slovar
//
//  Created by Антон Уханов on 14.7.24..
//

import Foundation
import SwiftUI



struct AddNewWordView: View {
   
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    private let colorsArray = [Color.green, Color.red, Color.yellow, Color.pink, Color.cyan, Color.orange]
    
    @State private var word: String = ""
    @State private var translation: String = ""
    @State private var categories: [String] = []
    @State private var newCategory: String = ""
    @State private var comment: String = ""
    @State private var tagsColors: [Color] = []
    var body: some View {
        VStack {
            Spacer()
            Text("I wish to remember..").font(.system(size: 30, design: .rounded)).bold().frame(height:70)
            Spacer()
            TextField("New word or phrase (required)", text: $word)
            TextField("Translation (required)",text: $translation)
            VStack {
                Text("Optional list of tags:").font(.system(size: 20, design: .rounded))
                if !categories.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(spacing: 5), GridItem(spacing:5)], spacing: 5)
                        {
                            ForEach(categories.indices, id: \.self) { index in
                                Text(categories[index]).font(.system(size: 20, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(tagsColors[index])
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                TextField("Tag", text: $newCategory).onSubmit {
                    if newCategory.count > 0  {
                        withAnimation{
                            let newElem = newCategory.trimmingCharacters(in: .whitespacesAndNewlines)
                            categories.append(newElem)
                            tagsColors.append(colorsArray.randomElement() ?? Color.orange)
                            newCategory = ""
                        }
                    }
                }
            }
            Text("Optional Comment").font(.system(size: 20, design: .rounded))
            TextEditor(text:$comment).shadow(radius: 1).frame(height: 100)
            Spacer()
            Button("Save"){
                addNewElement()
            }.foregroundColor(.white)
            .padding()
            .padding(.horizontal, 80)
            .background((word.isEmpty || translation.isEmpty) ? Color.gray : Color.blue)
            .cornerRadius(15)
            .disabled(word.isEmpty || translation.isEmpty)
        }
        .frame(width: 300)
        .padding()
        .textFieldStyle(.roundedBorder)
        Spacer()
    }
    func addNewElement(){
        context.insert(WordData(word: self.word, translation: self.translation, categories: self.categories, comment: self.comment, dateCreation: Date()))
        do {
            try context.save()
        } catch {
            fatalError("Error saving word data")
        }
        dismiss()
    }
}
#Preview {
    AddNewWordView()
}
