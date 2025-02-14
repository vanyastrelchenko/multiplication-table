//
//  AppPreferences.swift
//  Animation
//
//  Created by Ivan on 13.05.2023.
//

import SwiftUI

struct buttons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 260, height: 40)
            .background(Color.green)
            .cornerRadius(20)
            .shadow(radius: 10)
            .bold()
    }
}

extension View {
    func buttonsStyle() -> some View {
        modifier(buttons())
    }
}

struct appPreferences: View {

    @ObservedObject var pref: preferences
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("Table: \(pref.choosenTablet)")
                        .buttonsStyle()
                    Text("Questions: \(pref.numberOfQuestions)")
                        .buttonsStyle()
                    Text("Random train: \(pref.randomTrainTitle)")
                        .buttonsStyle()
                }
                
                VStack {
                    Text("Select the table you want to train:")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.white)
                    
                HStack {
                    ForEach(2..<10) { table in
                        Button {
                            pref.choosenTablet = table
                            pref.randomTrain = false
                            pref.randomTrainTitle = "Off"
                        }
                    label: {
                        Image(systemName: "\(table).circle")
                            .font(.system(size: 22))
                            .bold()
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    }
                }
                .frame(width: 380, height: 50)
                .background(Color.green.opacity(0.9))
                
                    Button {
                        pref.randomTrain = true
                        pref.randomTrainTitle = "On"
                    }
                label: {
                    Text("Train the whole table")
                        .font(.system(size:25))
                        .bold()
                        .foregroundColor(.blue)
                }
                .frame(width: 380, height: 50)
                .background(Color.green.opacity(0.9))
                    
                }
                .frame(height: 220)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
                .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    Text("How many questions do you need?")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack {
                        ForEach(5..<10) { question in
                            Button {
                                pref.numberOfQuestions = question
                            }
                        label: {
                            Image(systemName: "\(question).circle")
                                .font(.system(size: 22))
                                .bold()
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        }
                    }
                    .frame(width: 380, height: 50)
                    .background(Color.green.opacity(0.9))
                }
                .frame(height: 150)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
                .shadow(radius: 10)
                
                Button("Save") {
                   dismiss()
                }
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 250, height: 40)
                .background(Color.green)
                .cornerRadius(20)
                .shadow(radius: 5)
                
                Spacer()
            }
            .background(
                Image("HD-wallpaper-blackboard-organism")
                    .resizable()
                    .scaledToFill()
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
    

    struct appPreferences_Previews: PreviewProvider {
        static var previews: some View {
            appPreferences(pref: preferences())
        }
    }
}
