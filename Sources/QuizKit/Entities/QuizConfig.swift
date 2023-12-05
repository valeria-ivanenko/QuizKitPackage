//
//  QuizConfig.swift
//  QuizKit
//
//  Created by Valeriia Ivanenko
//

import Foundation
import UIKit

/// `QuizConfig` defines the visual and interactive properties of a quiz.
public struct QuizConfig {
    /// The background color of the quiz view.
    var background: UIColor
    
    /// The font used for text in the quiz.
    var font: UIFont
    
    /// The alignment of text in the quiz.
    var textAlignment: NSTextAlignment
    
    /// The color of the text for the question label.
    var labelTextColor: UIColor
    
    /// The color of the text for options.
    var optionsTextColor: UIColor
    
    /// The border color of the option buttons.
    var optionsBorderColor: CGColor
    
    /// The border width of the option buttons.
    var optionsBorderWidth: CGFloat
    
    /// The spacing between option buttons.
    var optionsSpacing: CGFloat
    
    /// The background color of option buttons.
    var optionsBackgroundColor: UIColor
    
    /// The corner radius of the option buttons.
    var optionsCornerRadius: CGFloat
    
    /// The spacing between UI elements in the quiz.
    var spacing: CGFloat
    
    /// The duration of animations in the quiz.
    var animationDuration: TimeInterval
    
    /// The corner radius of the quiz view.
    var quizCornerRadius: CGFloat
    
    /// The shadow color of the quiz view.
    var quizShadowColor: CGColor
    
    /// The shadow opacity of the quiz view.
    var quizShadowOpacity: Float
    
    /// The shadow radius of the quiz view.
    var quizShadowRadius: CGFloat
    
    /// The shadow offset of the quiz view.
    var quizShadowOffset: CGSize
    
    /// Initializer
    public init(background: UIColor = .blue, font: UIFont = .systemFont(ofSize: 21), textAlignment: NSTextAlignment = .left, labelTextColor: UIColor = .white, optionsTextColor: UIColor = .blue, optionsBorderColor: CGColor = UIColor.white.cgColor, optionsBorderWidth: CGFloat = 1, optionsSpacing: CGFloat = 10, optionsBackgroundColor: UIColor = .white, optionsCornerRadius: CGFloat = 8, spacing: CGFloat = 20, animationDuration: TimeInterval = 0.7, quizCornerRadius: CGFloat = 10, quizShadowColor: CGColor = UIColor.black.cgColor, quizShadowOpacity: Float = 0.2, quizShadowRadius: CGFloat = 10, quizShadowOffset: CGSize = CGSize(width: 0, height: 2)) {
        self.background = background
        self.font = font
        self.textAlignment = textAlignment
        self.labelTextColor = labelTextColor
        self.optionsTextColor = optionsTextColor
        self.optionsBorderColor = optionsBorderColor
        self.optionsBorderWidth = optionsBorderWidth
        self.optionsSpacing = optionsSpacing
        self.optionsBackgroundColor = optionsBackgroundColor
        self.optionsCornerRadius = optionsCornerRadius
        self.spacing = spacing
        self.animationDuration = animationDuration
        self.quizCornerRadius = quizCornerRadius
        self.quizShadowColor = quizShadowColor
        self.quizShadowOpacity = quizShadowOpacity
        self.quizShadowRadius = quizShadowRadius
        self.quizShadowOffset = quizShadowOffset
    }
}
