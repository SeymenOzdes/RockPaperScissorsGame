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
    @State private var purposeGame = Int.random(in: 0...1) // win or lose randomness olmasını sağlıyor.
    @State private var userChoice: Int = 4 // I'm not sure/ 4. sırada hiçbir shape yok, başlangıçta no selection yapmak için böyle yaptım.
    
    
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
