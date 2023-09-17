//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Seymen Özdeş on 13.09.2023.
//

import SwiftUI

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .clipShape(Capsule())
            .frame(width: 200, height: 200)
    }
}
extension View {
    func imageModifier() -> some View {
        modifier(ImageModifier())
    }
}

struct ContentView: View {
    @State private var shapes = ["Rock✊", "Paper🫱", "Scissor✌️"]
    @State private var images = ["RockImage", "PaperImage", "BlackScissorImage"]
    @State private var purposes = ["Win", "Lose"]
    @State private var outcomeTitle: String = ""
    @State private var appSelectedShape = Int.random(in: 0...2)
    @State private var purposeGame = Int.random(in: 0...1) // It ensures win or lose randomness.
    @State private var showingScore: Bool = false
    @State private var alertPresented = false
    @State private var wasCorrect = false
    @State private var hasEnded = false
    @State private var userChoice: Int?
    @State private var rounds: Int = 0
    @State private var score: Int = 0
    
    var toWin: String {
        if shapes[appSelectedShape] == "Rock✊" { // returns the winning answer
            return "Paper🫱"
        }
        else if shapes[appSelectedShape] == "Paper🫱" {
            return "Scissor✌️"
        }
        else {
            return "Rock✊"
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                VStack(spacing: 20) {
                    Section {
                        VStack {
                            Text("Selection of system")
                                .font(.title2.bold())
                            Text("\(shapes[appSelectedShape])")
                                .font(.title.bold())
                                .foregroundColor(.blue)
                            Image("\(images[appSelectedShape])")
                                .resizable()
                                .imageModifier()
                        }
                    }
                    Section {
                        Text("Purpose of the game")
                            .font(.title2.bold())
                        Picker("Purpose", selection: $purposeGame) {
                            ForEach(0..<2) {
                                Text("\(purposes[$0])")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section {
                        Text("Make your choice")
                            .font(.title2.bold())
                        HStack(spacing: 15) {
                            ForEach(0..<3, id: \.self) { row in
                                Button(shapes[row]) {
                                    let userSelect = shapes[row]
                                    checkResult(user: userSelect)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    Section { // final section
                        HStack {
                            Text("Score: \(score)")
                                .font(.title2.bold())
                        }
                        .alert(outcomeTitle, isPresented: $alertPresented){
                            Button("Continue", action: nextQuestion)
                        } message: {
                            if wasCorrect == true {
                                Text("Correct! Your score was \(score)")
                            }
                            else {
                                Text("Please, try again!")
                            }
                        }
                        .alert("Game over", isPresented: $hasEnded) {
                            Button("Restart game", action: gameOver)
                        } message: {
                            if wasCorrect == true {
                                Text("Correct! Your final score was \(score)")
                            } else {
                                Text("Wrong! Your final score was \(score)")
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    func checkResult(user: String) {
        rounds += 1
        if rounds <= 10 {
            if user == toWin && purposeGame == 0 {
                outcomeTitle = "Correct!"
                wasCorrect = true
                alertPresented = true
                score += 1
            }
            else if user == toWin && purposeGame == 1 {
                outcomeTitle = "Wrong!"
                wasCorrect = false
                alertPresented = true
                score -= 1
            }
           else if user != toWin && purposeGame == 0 {
                outcomeTitle = "Wrong!"
                wasCorrect = false
                alertPresented = true
                score -= 1
            }
            else if user != toWin && purposeGame == 1 {
                outcomeTitle = "Correct!"
                wasCorrect = true
                alertPresented = true
                score += 1
            }
        }
        if alertPresented == false {
            hasEnded = true
        }
           
    }
    
    func nextQuestion() {
        purposeGame = Int.random(in: 0...1)
        appSelectedShape = Int.random(in: 0...2)
    }
    func gameOver() {
        nextQuestion()
        rounds = 0
        score = 0 
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
