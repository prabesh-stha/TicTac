//
//  NameView.swift
//  TicTac
//
//  Created by Prabesh Shrestha on 25/08/2024.
//

import SwiftUI

struct NameView: View {
    @StateObject private var viewModel = NameViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Player 1")
                .font(.headline)
            TextField("Enter player 1 name", text: $viewModel.player1)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("Player 2")
                .font(.headline)
            TextField("Enter player 2 name", text: $viewModel.player2)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            NavigationLink {
                TicTacView(player1: viewModel.player1, player2: viewModel.player2)
            } label: {
                Text("Start Game")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top)

        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        NameView()
    }
}
