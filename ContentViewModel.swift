//
//  ContentViewModel.swift
//  Guess the Number
//
//  Created by MultiLab PRT 17 on 07/01/2025.
//

// ContentViewModel.swift
import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

class ContentViewModel: ObservableObject {
    @Published var numeroAleatorio: Int = Int.random(in: 1...100)
    @Published var mensagem: String = "Você consegue adivinhar?"
    @Published var tentativas: Int = 0
    @Published var historico: [Int] = []
    @Published var jogoConcluido: Bool = false
    @Published var exibirHistorico: Bool = false
    @Published var dificuldade: String = "Médio"
    @Published var palpite: String = ""
    
    var mensagemInicial: String {
            if jogoConcluido {
                return "" // Retorna uma string vazia quando o jogo está concluído
            } else {
                return "Você tem \(limiteTentativas) chances.\nVamos lá!"
            }
        }
    
    let buttonGradient = LinearGradient(
        colors: [Color(red: 0.0, green: 0.8, blue: 0.8), //turquesa
                 Color(red: 0.9, green: 0.1, blue: 0.6) // Pink
                 ],
        startPoint: .leading,
        endPoint: .trailing
        )
    
    let backgroud = Color(hex: "#fbc204")
    
    var limiteTentativas: Int {
        switch dificuldade {
        case "Fácil":
            return 6
        case "Médio":
            return 10
        default:
            return 15
        }
    }
    
    var intervalo: ClosedRange<Int> {
        switch dificuldade {
        case "Fácil":
            return 1...50
        case "Médio":
            return 1...100
        default:
            return 1...200
        }
    }
    func verificarPalpite() {
        guard let palpiteInt = Int(palpite), intervalo.contains(palpiteInt) else {
            mensagem = "Por favor, insira um número válido entre \(intervalo.lowerBound) e \(intervalo.upperBound)."
            palpite = ""
            return
        }
        if !exibirHistorico {
            exibirHistorico = true
        }
        historico.append(palpiteInt) // Adiciona o palpite no histórico

        historico.sort()  // Ordena o histórico em ordem crescente

        tentativas += 1  //incrementa as tentativas

        // Lógica de verificação do palpite
        if palpiteInt == numeroAleatorio {
            mensagem = "Parabéns! Você acertou em \(tentativas) tentativas! O número era \(numeroAleatorio)."
            jogoConcluido = true
        } else if palpiteInt < numeroAleatorio {
            mensagem = "O número é maior que \(palpiteInt)."
        } else {
            mensagem = "O número é menor que \(palpiteInt)."
        }
        
        // Se o jogador exceder o limite de tentativas, encerra o jogo
        if tentativas >= limiteTentativas && !jogoConcluido {
            mensagem = "Você perdeu! O número era \(numeroAleatorio). Tente novamente!"
            jogoConcluido = true
        }
        
        palpite = ""  //limpa a textfield após cada palpite
    }
    
    // Função para reiniciar o jogo
    func reiniciarJogo() {
        switch dificuldade {
        case "Fácil":
            numeroAleatorio = Int.random(in: 1...50)
        case "Médio":
            numeroAleatorio = Int.random(in: 1...100)
        default:
            numeroAleatorio = Int.random(in: 1...200)
        }
        tentativas = 0
        historico.removeAll()
        palpite = ""
        jogoConcluido = false
        exibirHistorico = false
    }
}
