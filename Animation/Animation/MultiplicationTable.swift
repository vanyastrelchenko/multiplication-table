//
//  MultiplicationTable.swift
//  Animation
//
//  Created by Ivan on 14.05.2023.
//

import Foundation
import SwiftUI


struct MultiplicationQuestion {
    var questionText: String
    var correctAnswer: Int
}

class preferences: ObservableObject {
    
    @Published var numberOfQuestions = 5
    @Published var choosenTablet = 2
    @Published var randomTrain = false
    @Published var randomTrainTitle = "Off"
    
}
