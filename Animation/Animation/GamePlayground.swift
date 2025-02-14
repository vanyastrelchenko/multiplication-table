//
//  GamePlayground.swift
//  Animation
//
//  Created by Ivan on 13.05.2023.
//

import SwiftUI

struct numbers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 70))
            .bold()
            .frame(width: 150, height: 100)
    }
}

extension View {
    func numberStyle() -> some View {
        modifier(numbers())
    }
}

struct GamePlayground: View {
    
    @StateObject var pref = preferences()
    
    @State private var scoreCounter = 0
    @State private var endOfTheGame = 0
    @State private var showGamePreferences = false
    @State private var showAllert = false
    @State private var start = false
    @State private var selectedButtonIndex: Int?
    @State private var isNumberTapped = false

    @State private var randomArray = [Int.random(in: 4...81), Int.random(in: 4...20), Int.random(in: 4...40)]
    
    @State private var x = Int.random(in: 2...9)
    @State private var y = Int.random(in: 2...9)
    
    var multiply: Int {
        let randomOn = pref.randomTrain
        
        var multipl: Int
        
        if randomOn {
            multipl = x * y
        } else {
            multipl = x * pref.choosenTablet
        }
        return multipl
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Spacer()
                
                HStack {
                    Button {
                        withAnimation {
                            showGamePreferences = true
                            gameOver()
                            start = false
                        }
                    } label: {
                        Text("Preferences")
                        Image(systemName: "hand.tap.fill")
                    }
                        
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 40)
                    .background(Color.green)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .sheet(isPresented: $showGamePreferences) {
                    appPreferences(pref: pref)
                }
                
                HStack {
                    withAnimation {
                        Text(start ? (pref.randomTrain ? "\(x) x \(y) = " : "\(x) x \(pref.choosenTablet) = ") : "a x b =")
                            .foregroundColor(.white)
                            .font(.system(size: 80).bold())
                            .shadow(radius: 20)
                    }
                }
                .frame(width: 385, height: 340)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()

                ForEach(0..<2) { row in
                    HStack(spacing: 50) {
                        ForEach(0..<2) { column in
                            let index = row * 2 + column
                            Button {
                                withAnimation {
                                    numberTapped(index)
                                    isNumberTapped = true
                                    selectedButtonIndex = index
                                }
                            } label: {
                                Text(start ? "\(randomArray[index])" : "c")
                            }
                            .numberStyle()
                            .background(isNumberTapped ? (selectedButtonIndex == randomArray.firstIndex(of: multiply) ? .green : .red) : .gray.opacity(0.6)).shadow(radius: 10)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .foregroundColor(.white)
                            .disabled(isNumberTapped)
                        }
                    }
                }

                    HStack {
                        Button(start ? "Score: \(scoreCounter)/\(pref.numberOfQuestions)" : "Start") {
                            withAnimation {
                                randomElement()
                                start.toggle()
                            }
                        }
                            .disabled(start)
                            .font(.title)
                            .bold()
                    }
                    .frame(width: 400, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    
                    Spacer()
                }
                .background(
                    Image("HD-wallpaper-blackboard-organism")
                        .resizable()
                        .scaledToFill()
                )
                .edgesIgnoringSafeArea(.all)
                .alert("Game over, your score is \(scoreCounter) out of \(pref.numberOfQuestions)", isPresented: $showAllert) {
                    Button("Start new game", action: gameOver)
                }
            }
        }
    
    func randomElement() {
        randomArray = []
        
        randomArray.append(Int.random(in: 4...81))
        
        while randomArray.count < 2 {
            let randomNumber_2 = Int.random(in: 4...21)
            
            if !randomArray.contains(randomNumber_2) {
                randomArray.append(randomNumber_2)
            }
        }
        
        while randomArray.count < 3 {
            let randomNumber_3 = Int.random(in: 4...40)
            
            if !randomArray.contains(randomNumber_3) {
                randomArray.append(randomNumber_3)
            }
        }
        
        while randomArray.count < 4{
            
            x = Int.random(in: 2...9)
            
            if !randomArray.contains(multiply) {
                randomArray.append(multiply)
            }
        }
        randomArray.shuffle()
    }
    
    func numberTapped(_ index: Int) {
        if index == randomArray.firstIndex(of: multiply) {
            scoreCounter += 1
        }
        
        endOfTheGame += 1
        
        if endOfTheGame == pref.numberOfQuestions {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {showAllert.toggle()}
        } else {
            if pref.randomTrain {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {y = Int.random(in: 2...9)}
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {randomElement()}
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {isNumberTapped = false}
    }
    
    func gameOver() {
        withAnimation {
            x = Int.random(in: 2...9)
            scoreCounter = 0
            endOfTheGame = 0
            randomElement()
        }
        }
    }
    
    
    struct GamePlayground_Previews: PreviewProvider {
        static var previews: some View {
            GamePlayground()
        }
    }
