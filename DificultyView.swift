//
//  DificultyView.swift
//  Guess the Number
//
//  Created by MultiLab PRT 17 on 09/01/2025.
//

import SwiftUI
import Foundation
struct DificultyView: View {
    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {

        ZStack {

            viewModel.backgroud
                .ignoresSafeArea()

            VStack {
                Text("Guess")
                    .font(.custom("Chalkduster", size: 60))
                    .foregroundColor(Color(red: 0.9, green: 0.1, blue: 0.6))
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 2)

                Text("the number")
                    .font(.custom("Chalkduster", size: 48))
                    .foregroundColor(Color(red: 0.0, green: 0.8, blue: 0.8))
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 2)

                Image("questionmark")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .shadow(color: .black.opacity(0.6), radius: 3, x: 2, y: 2)

                Text("Escolha o nível de dificuldade:")
                    .font(.custom("Avenir", size: 22))
                    .multilineTextAlignment(.center)

                Picker("Dificuldade", selection: $viewModel.dificuldade) {
                    Text("Fácil")
                        .tag("Fácil")

                    Text("Médio")
                        .tag("Médio")

                    Text("Difícil")
                        .tag("Difícil")

                }
                .pickerStyle(.segmented)
                .background(viewModel.buttonGradient.opacity(0.7)) // Fundo translúcido para o Picker
                .cornerRadius(10) // Arredonda os cantos
                .padding(.horizontal, 20) // Espaçamento lateral

                .onChange(of: viewModel.dificuldade) {
                    viewModel.reiniciarJogo()
                }

                Spacer()

                NavigationLink(destination: ContentView(viewModel: viewModel)) {

                    Text("Go!")
                        .font(.custom("Chalkduster", size: 30))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 60)
                        .background(viewModel.buttonGradient)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.white.opacity(0.5), lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 2, y: 2)
                }
            }

            .padding()
        }
    }
}
#Preview {
    DificultyView()
}
