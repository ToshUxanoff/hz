//
//  ContentView.swift
//  Slovar
//
//  Created by Антон Уханов on 14.7.24..
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.isPresented) var presented
    
    @State var searchSubstring: String = ""
    @State var selectedTags: [String] = []
    @State var uniqueTagsList: [String] = []
    
    @Query(sort:\WordData.dateCreation, order: .reverse) var allWords: [WordData]
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search",text: $searchSubstring).padding().textFieldStyle(.roundedBorder)
                //Text(uniqueTagsList[0])
                ScrollView(.horizontal){
                    HStack {
                        ForEach(uniqueTagsList, id: \.self) { tag in
                            Button(tag) {
                                withAnimation(.easeIn) {
                                    toggleTag(tag:tag)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(selectedTags.contains(tag) ? Color.green : Color.gray)
                        }
                    }
                }.padding(.horizontal, 10)
                List {
                    ForEach(allWords.filter { word in
                        (searchSubstring.isEmpty ||
                        word.word.lowercased().contains(searchSubstring.lowercased()) ||
                        word.translation.lowercased().contains(searchSubstring.lowercased())) &&
                        (selectedTags.isEmpty ||
                        !Array(Set(selectedTags).intersection(word.categories)).isEmpty)
                    }) { word in
                        WordRowView(word: word.word, translation: word.translation)
                    }.onDelete { indexSet in
                        indexSet.forEach { (i) in
                            context.delete(allWords[i])
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNewWordView()) {
                        Text("+ Add New Word")
                    }.modelContext(context)
                }
            }
        }.onAppear(perform:updateUniqueTagsList)
        .onChange(of: allWords) {
            updateUniqueTagsList()
        }
    }
    
    func updateUniqueTagsList() {
        var result: [String] = []
        allWords.forEach { item in
            item.categories.forEach{ tag in
                result.append(tag)
            }
        }
        uniqueTagsList = Array(Set(result)).sorted()
    }
    func toggleTag(tag: String) {
        if selectedTags.contains(tag) {
            selectedTags = selectedTags.filter {$0 != tag}
        } else {
            selectedTags.append(tag)
        }
    }
}

#Preview {
    ContentView(uniqueTagsList: ["asb", "asd"])
}
