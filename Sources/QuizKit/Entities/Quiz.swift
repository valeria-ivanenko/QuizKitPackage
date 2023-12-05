//
//  Quiz.swift
//  QuizKit
//
//  Created by Valeriia Ivanenko
//

import Foundation

/// `Quiz` manages the quiz logic and keeps track of the quiz state.
public struct Quiz {
    /// An array of `Question` objects. (Read-only)
    private(set) var questions: [Question]
    
    /// Configuration for the quiz's appearance and behavior.
    private(set) var config: QuizConfig
    
    /// The index of the current question. (Read-only)
    private(set) var currentQuestionIndex: Int = 0
    
    /// The count of correctly answered questions. (Read-only)
    private(set) var correctAnswersCount: Int = 0
    
    /// Initializes the quiz with a set of questions and a configuration.
    /// - Parameters:
    ///   - questions: An array of `Question` objects.
    ///   - config: `QuizConfig` object to configure the quiz.
    public init(questions: [Question], config: QuizConfig) {
        self.questions = questions
        self.config = config
    }
    
    /// Returns the current question or `nil` if no more questions are available.
    /// - Returns: The current `Question` object or `nil`.
    func currentQuestion() -> Question? {
        if currentQuestionIndex < questions.count {
            return questions[currentQuestionIndex]
        }
        return nil
    }
    
    /// Checks the selected answer index against the correct answer, returns `true` if correct, and advances to the next question.
    /// - Parameter index: The index of the selected answer.
    /// - Returns: Boolean indicating whether the selected answer is correct.
    mutating func checkAnswer(_ index: Int) -> Bool {
        guard let currentQuestion = currentQuestion() else { return false }
        let isCorrect = currentQuestion.correctOptionIndex == index
        if isCorrect {
            correctAnswersCount += 1
        }
        currentQuestionIndex += 1
        return isCorrect
    }
    
    /// Resets the quiz to its initial state.
    mutating func resetQuiz() {
        currentQuestionIndex = 0
        correctAnswersCount = 0
    }
}
