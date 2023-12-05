//
//  Question.swift
//  QuizKit
//
//  Created by Valeriia Ivanenko
//

import Foundation

/// Represents a single quiz question.
public struct Question {
    /// The text of the quiz question.
    var questionLabel: String
    
    /// An array of options for the question.
    var options: [String]
    
    /// The index of the correct option in the `options` array.
    var correctOptionIndex: Int
    
    /// The index of the correct option in the `options` array.
    public init(questionLabel: String, options: [String], correctOptionIndex: Int) {
        self.questionLabel = questionLabel
        self.options = options
        self.correctOptionIndex = correctOptionIndex
    }
}
