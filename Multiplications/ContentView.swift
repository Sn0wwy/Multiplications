//
//  ContentView.swift
//  Multiplications
//
//  Created by Nacho Alaves on 23/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var chosenNum = 0
    @State private var numQuestions = 5
    @State private var animationAmount = 1.0
    @State private var randomNumber = Int.random(in: 2...12)
    @State private var correctAnswers = 0
    @State private var showAlert = false
    
    @State private var userAnswer = 0
    @State private var count = 0

    
    let possibleQuestions = [5, 10, 20]

    var body: some View {
        NavigationView {
            VStack {
                    Section {
                        Text("What times table do you want to practice?")
                            .font(.subheadline)
                        Picker("Number", selection: $chosenNum) {
                            ForEach(2...12, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                    
                    Section {
                        Text("How many questions do you want to be asked?")
                            .font(.subheadline)
                        Picker("Questions", selection: $numQuestions) {
                            ForEach(possibleQuestions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                
                if (chosenNum != 0 && numQuestions != 0) {
                    Section {
                        Text("What is \(chosenNum) x \(randomNumber)?")
                            .font(.title2)
                        
                        TextField("Amount", value: $userAnswer, format: .number)
                            .keyboardType(.decimalPad)
                            .padding()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        count += 1
                        
                        if(userAnswer == (chosenNum * randomNumber)) {
                            correctAnswers += 1
                        }
                        
                        if(count == numQuestions) {
                            showAlert = true
                        }
                        
                        randomNumber = Int.random(in: 2...12)
                        
                    } label: {
                        Text("Submit!")
                    }
                    .padding(30)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.yellow)
                            .scaleEffect(animationAmount)
                            .opacity(2 - animationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                    )
                    .onAppear {
                        animationAmount = 2
                    }
                }
                
                
                
                Spacer()
            }
            .navigationTitle("Multiplication trainer")
            .alert("You got \(correctAnswers) questions right out of \(numQuestions)", isPresented: $showAlert) {
                Button("Restart", action: performReset)
            }
        }
    }
    
    func performReset() {
        chosenNum = 0
        numQuestions = 5
        count = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
