//
//  WordDataModel.swift
//  Slovar
//
//  Created by Антон Уханов on 14.7.24..
//

import Foundation
import SwiftData

@Model
class WordData {
    var word: String
    var translation: String
    var categories: [String]
    var comment: String
    var dateCreation: Date
    init(word: String, translation: String, categories: [String], comment: String, dateCreation: Date) {
        self.word = word
        self.translation = translation
        self.categories = categories
        self.comment = comment
        self.dateCreation = dateCreation
    }
}
