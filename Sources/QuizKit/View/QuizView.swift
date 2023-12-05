//
//  QuizView.swift
//  QuizKit
//
//  Created by Valeriia Ivanenko
//

import UIKit

/// `QuizView` is a UIView subclass that manages the display and interaction of a quiz.
public final class QuizView: UIView {
    // MARK: - Properties
    /// The `Quiz` object containing the quiz data.
    private var quiz: Quiz? = nil
    
    /// The `QuizConfig` object containing the quiz configuration.
    private var config: QuizConfig? = nil
    
    // MARK: - Subviews
    /// Label displaying the current question.
    private var questionLabel: UILabel!
    
    /// Array of buttons representing the quiz options.
    private var optionButtons: [UIButton] = []
    
    /// Label displaying the quiz results.
    private var resultLabel: UILabel!
    
    /// Button to reset the quiz and start over.
    private var resetButton: UIButton!
    
    /// Progress view showing the user's progress through the quiz.
    private var progressBar: UIProgressView!
    
    // MARK: - Inits
    /// Initializes a `QuizView` with a given quiz and frame.
    /// - Parameters:
    ///   - quiz: The `Quiz` object to display.
    ///   - frame: The frame for the quiz view.
    public init(quiz: Quiz, frame: CGRect) {
        self.quiz = quiz
        super.init(frame: frame)
        
        setupUI(frame: frame)
        displayCurrentQuestion()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private
private extension QuizView {
    /// Sets up the user interface components of the quiz view.
    func setupUI(frame: CGRect) {
        guard let config = self.quiz?.config else {
            return
        }
        // Initializing the subviews
        progressBar = UIProgressView()
        questionLabel = UILabel()
        resultLabel = UILabel()
        resetButton = UIButton(type: .system)
        
        // Turning off the translatesAutoresizingMaskIntoConstraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.resultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding subviews
        self.addSubview(progressBar)
        self.addSubview(questionLabel)
        self.addSubview(resultLabel)
        self.addSubview(resetButton)
        
        // Setting up the view, its shadow
        self.layer.cornerRadius = config.quizCornerRadius
        self.layer.shadowColor = config.quizShadowColor
        self.layer.shadowOpacity = config.quizShadowOpacity
        self.layer.shadowOffset = config.quizShadowOffset
        self.layer.shadowRadius = config.quizShadowRadius
        self.backgroundColor = config.background
        
        // Setting up the UIProgressView
        progressBar.progress = 0.0
        progressBar.backgroundColor = .white
        progressBar.layer.cornerRadius = 5.0
        progressBar.clipsToBounds = true
        
        // Setting up the label that contains question
        questionLabel.numberOfLines = 0
        questionLabel.textColor = config.labelTextColor
        questionLabel.textAlignment = config.textAlignment
        questionLabel.font = config.font
        
        // Setting up the label with results
        resultLabel.textAlignment = .center
        resultLabel.font = config.font
        resultLabel.textColor = config.labelTextColor
        resultLabel.isHidden = true
        
        // Setting up the reset button
        resetButton.backgroundColor = .white
        resetButton.setTitleColor(config.optionsTextColor, for: .normal)
        resetButton.layer.cornerRadius = config.optionsCornerRadius
        resetButton.layer.borderWidth = config.optionsBorderWidth
        resetButton.layer.borderColor = config.optionsBorderColor
        resetButton.setTitle("Reset Quiz", for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        resetButton.isHidden = true
        
        // Constraints for view
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        
        // Constraints for progress bar
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: config.spacing / 2),
            progressBar.topAnchor.constraint(equalTo: topAnchor, constant: config.spacing / 4),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.spacing),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -config.spacing)
        ])
        
        // Constraints for question label
        let questionLabelHeight = (self.bounds.height - (config.spacing * 3)) / 3
        NSLayoutConstraint.activate([
            questionLabel.heightAnchor.constraint(equalToConstant: questionLabelHeight),
            questionLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: config.spacing / 4),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.spacing),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -config.spacing)
        ])
        
        // Constraints for result label
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Constraints for reset button
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: config.spacing),
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: self.bounds.width / 3)
        ])
    }
    
    /// Displays the current question in the quiz.
    func displayCurrentQuestion()  {
        guard let quiz = self.quiz, 
                let currentQuestion = quiz.currentQuestion() else { return }
        let config = quiz.config
        
        // Calculating the height of each option button
        let sumSpacing = config.spacing * 3
        let optionsCount = CGFloat(currentQuestion.options.count)
        let optionButtonHeight = (((self.bounds.height - sumSpacing) * 2.0 / 3.0) - (config.optionsSpacing * optionsCount)) / optionsCount
        questionLabel.text = currentQuestion.questionLabel
        
        // Removing previous option buttons, if they existed
        optionButtons.forEach { $0.removeFromSuperview() }
        optionButtons.removeAll()
        
        // Adding options to the view
        for (index, option) in currentQuestion.options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.tag = index
            
            // Configuring the button using the QuizConfig
            button.setTitleColor(config.optionsTextColor, for: .normal)
            button.backgroundColor = config.optionsBackgroundColor
            button.layer.cornerRadius = config.optionsCornerRadius
            button.layer.borderWidth = config.optionsBorderWidth
            button.layer.borderColor = config.optionsBorderColor
            
            // Setting up constraints for option button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: optionButtonHeight).isActive = true
            
            // Adding an action on touch up inside
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            
            // Adding to view
            addSubview(button)
            optionButtons.append(button)
        }
        
        updateOptionButtonLayout()
    }
    
    /// Updates the layout of option buttons.
    func updateOptionButtonLayout() {
        guard let config = self.quiz?.config else { return }
        
        for (index, button) in optionButtons.enumerated() {
            if index == 0 {
                // The first option button should be spaced from the question label
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: config.spacing)
                ])
            } else {
                // Other option buttons spaced due to configuration
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: optionButtons[index - 1].bottomAnchor, constant: config.optionsSpacing)
                ])
            }
            // Activating the trailing and leading constraints
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.optionsSpacing),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -config.optionsSpacing)
            ])
        }
    }
    
    /// Handles the selection of an option by the user.
    /// - Parameter sender: The option button that was tapped.
    @objc func optionSelected(_ sender: UIButton) {
        let selectedOptionIndex = sender.tag
        let isCorrect = self.quiz?.checkAnswer(selectedOptionIndex)
        
        // Highliting the button with color, depending on correctness
        sender.backgroundColor = isCorrect ?? false ? .green : .red
        sender.setTitleColor(isCorrect ?? false ? .black : .white, for: .normal)
        optionButtons.forEach { $0.isEnabled = false }
        
        // As question is answered - go to the next question
        displayNextQuestion()
    }
    
    /// Displays the next question or the results if the quiz is finished.
    func displayNextQuestion() {
        guard let quiz = self.quiz else { return }
        let config = quiz.config
        
        if quiz.currentQuestion() == nil {
            // If the user has finished the quiz, we show the results label and the reset quiz button
            UIView.animate(withDuration: config.animationDuration, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.alpha = 1
                self.progressBar.progress = 1.0
                self.resultLabel.text = "Your score: \(quiz.correctAnswersCount)/\(quiz.questions.count)"
                self.resultLabel.font = config.font
                
                self.resultLabel.isHidden = false
                self.resetButton.isHidden = false
                self.questionLabel.isHidden = true
                
                self.optionButtons.forEach { $0.isHidden = true }
            })
        } else {
            // If the user has not finished the quiz, we show the next question
            UIView.animate(withDuration: config.animationDuration, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.alpha = 1
                // Calculating the value for the progress bar
                self.progressBar.progress = Float(quiz.currentQuestionIndex) / Float(quiz.questions.count - 1)
                self.optionButtons.forEach { $0.backgroundColor = .none }
                self.optionButtons.forEach { $0.isEnabled = true }
                self.displayCurrentQuestion()
            })
        }
    }
    
    /// Handles the reset action to restart the quiz.
    @objc func resetButtonTapped() {
        guard let config = self.quiz?.config else { return }
        // Animvating the quiz
        UIView.animate(withDuration: config.animationDuration, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.alpha = 1
            // Updating model
            self.quiz?.resetQuiz()
            self.progressBar.progress = 0.0
            
            // Hiding the results subviews
            self.resultLabel.isHidden = true
            self.resetButton.isHidden = true
            self.questionLabel.isHidden = false
            self.optionButtons.forEach { $0.isHidden = false }
            
            self.displayCurrentQuestion()
        })
    }
}

