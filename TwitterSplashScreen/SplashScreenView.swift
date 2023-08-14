//
//  SplashScreenView.swift
//  TwitterSplashScreen
//
//  Created by Juan Camilo Marín Ochoa on 13/08/23.
//

import SwiftUI

struct SplashScreenView: View {
    // Variable que controla la animación de la pantalla de inicio
    @State private var isAnimating: Bool = false
    
    // Determina si el splash screen no se muestra
    @State private var hideSplashScreen: Bool = false
    
    var body: some View {
        ZStack {
            MainView()
                .opacity(isAnimating ? 1 : 0)
                .ignoresSafeArea()
            
            if !hideSplashScreen {
                buildMask()
            }
        }
        .onAppear {
            // Retraso de 0.4 segundos
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                // Animación de 0.4 segundos
                withAnimation(.easeInOut(duration: 0.4)) {
                    isAnimating.toggle()
                }
                
                // Oculta el splash screen después de 0.3 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    hideSplashScreen = true
                }
            }
        }
    }
    
    private func buildMask() -> some View {
        Color.blue
            .mask(
                Rectangle()
                    .overlay(
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .scaleEffect(isAnimating ? 35 : 1)
                            .blendMode(.destinationOut)
                    )
            )
            .ignoresSafeArea()
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
