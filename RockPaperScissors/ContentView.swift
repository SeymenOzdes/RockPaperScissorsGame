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
    @State private var selectedShape = Int.random(in: 0...2)
    @State private var purposeGame = Int.random(in: 0...1) // It ensures win or lose randomness.
    @State private var userChoice: Int = 4 // There is no shape in the 4th row, I did this to have no selection at the beginning.
    
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(spacing: 20) {
                    Section {
                        VStack {
                            Text("Selection of system")
                                .font(.title2.bold())
                            Text("\(shapes[selectedShape])")
                                .font(.title.bold())
                                .foregroundColor(.blue)
                            Image("\(images[selectedShape])")
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
                        VStack{
                            Text("make your choice")
                                .font(.title2.bold())
                            Picker("UserChoice", selection: $userChoice) {
                                ForEach(0..<3) {
                                    Text("\(shapes[$0])")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
