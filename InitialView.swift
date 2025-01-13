//
//  InitialView.swift
//  Guess the Number
//
//  Created by MultiLab PRT 17 on 08/01/2025.
//

import SwiftUI
struct InitialView: View {
   
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            ZStack{

                Image("InitialImage")
                    .resizable()         // Para ajustar o tamanho
                    .scaledToFill()       // Para preservar a proporção
                    .clipped() // Garante que o conteúdo excedente será cortado
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing:20){

                    Spacer()

                    VStack(spacing:0){

                        Text("Guess")
                            .font(.custom("Chalkduster", size: 60))
                            .foregroundColor(Color(red: 0.9, green: 0.1, blue: 0.6))
                            .shadow(color: .black.opacity(0.7), radius: 5, x: 2, y: 2)

                        Text("The Number!")
                            .font(.custom("Chalkduster", size: 48))
                            .foregroundColor(Color(red: 0.0, green: 0.8, blue: 0.8))
                            .shadow(color: .black.opacity(0.7), radius: 5, x: 2, y: 2)
                            .padding(.bottom, 80)

                        NavigationLink(destination: DificultyView(viewModel: viewModel)) {

                            Text("PLAY!")
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
                    .padding(.top, 50)
                }
            }
            .preferredColorScheme(.light)
        }
    }
}
#Preview {
    InitialView()
}
