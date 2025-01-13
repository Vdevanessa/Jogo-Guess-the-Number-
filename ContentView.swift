//
//  ContentView.swift
//  Guess the Number
//
//  Created by MultiLab PRT 17 on 06/01/2025.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @Environment(\.dismiss) private var dismiss


    var body: some View {

        ZStack {
            
            viewModel.backgroud
                .ignoresSafeArea()
            

            VStack {
                Text("Guess")
                    .font(.custom("Chalkduster", size: 60))
                    .foregroundColor(Color(red: 0.9, green: 0.1, blue: 0.6))
                    .shadow(color: .black.opacity(0.6), radius: 5, x: 2, y: 2)
                    .padding(.top, 10)
                
                Text("the number")
                    .font(.custom("Chalkduster", size: 48))
                    .foregroundColor(Color(red: 0.0, green: 0.8, blue: 0.8))
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 2, y: 2)
                    .padding(.bottom)
               
                Spacer()
                
                                
                Text("Estou pensando em um número entre: \(viewModel.intervalo.lowerBound)...\(viewModel.intervalo.upperBound)")
                    .font(.custom("Avenir", size: 22))
                    .multilineTextAlignment(.center)
                               
                Text(viewModel.mensagem)
                    .font(.custom("Chalkduster", size: 20))
                    .foregroundStyle(Color(red: 0, green: 0.5, blue: 0.5))
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    .foregroundStyle(.white)
                    .bold()
                
                if !viewModel.mensagemInicial.isEmpty {
                    Text(viewModel.mensagemInicial)
                        .font(.custom("Avenir", size: 20))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                TextField("Seu Palpite", text: $viewModel.palpite)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(width: 200)
                    .padding(0)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 2, y: 2)
                    .opacity(viewModel.jogoConcluido ? 0 : 1)
                
                // Botão para verificar ou reiniciar o jogo
                Button(action: {
                    if viewModel.jogoConcluido {
                        viewModel.reiniciarJogo()
                        dismiss()
                    } else {
                        viewModel.verificarPalpite()
                        viewModel.exibirHistorico = true
                    }
                })
                {
                    Text(viewModel.jogoConcluido ? "Reiniciar" : "Verificar")
                        .font(.custom("Chalkduster", size: 25))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(viewModel.buttonGradient)
                        .cornerRadius(20)
                    
                }
                .shadow(color: .black.opacity(0.5), radius: 5, x: 2, y: 2)
                .padding()
                
                
                Spacer()
                
                if viewModel.exibirHistorico {
                    if !viewModel.historico.isEmpty {
                        Text("Histórico de palpites:")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Text(viewModel.historico.map { "\($0)" }.joined(separator: ", "))
                            .font(.custom("Avenir", size: 17))
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                    }
                } else {
                    // Espaço reservado para evitar mudanças no layout
                    Spacer().frame(height: 40) // Ajuste a altura conforme necessário
                }
            }
            .padding()

        }
    }
}
#Preview {
    ContentView()
}
