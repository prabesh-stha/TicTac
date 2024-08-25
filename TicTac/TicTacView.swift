//
//  TicTacView.swift
//  TicTac
//
//  Created by Prabesh Shrestha on 25/08/2024.
//

import SwiftUI

struct TicTacView: View {
    let player1: String
    let player2: String
    @StateObject private var viewModel = TicTacViewModel()

    var body: some View {
            VStack {
                VStack{
                    ForEach(0..<3, id: \.self){row in
                        HStack{
                            ForEach(0..<3, id: \.self){col in
                                Button {
                                    if viewModel.makeMove(row: row, col: col){
                                        viewModel.winner = viewModel.checkWinner()
                                        viewModel.isDraw = viewModel.checkDraw(winner: viewModel.winner)
                                        viewModel.showScore(winner: viewModel.winner)
                                    }
                                } label: {
                                    Text(viewModel.board[row][col].symbol)
                                        .font(.system(size: 60))
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.black)
                                        .background(Color.blue.opacity(0.2))
                                        .clipShape(Circle())
                                }
                                .disabled(viewModel.board[row][col] != .none || viewModel.winner != .none)
                                .padding(.all, 5)
                                
                            }
                        }
                    }
                }
                .frame(width: 80 * 3.5, height: 80 * 3.5)
                
                .padding()
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .onChange(of: viewModel.winner, {
                    if viewModel.winner != .none{
                        viewModel.showAlert = true
                        viewModel.message = "\(viewModel.winner == .x ? player1 : player2) wins!🥳"
                        viewModel.winner = .none
                    }
                })
                .onChange(of: viewModel.isDraw,{
                    viewModel.showAlert = true
                    viewModel.message = "It's a draw!😔"
                    viewModel.isDraw = false
                })
                .alert("", isPresented: $viewModel.showAlert, actions: {
                    Button("Restart"){
                        viewModel.restart()
                    }
                }, message: {
                    Text(viewModel.message)
                })
            .navigationTitle("Tic Tac Toe")
                
                Text("\(viewModel.currentPlayer == .x ? player1 : player2) turns")
                Button("Restart"){
                    viewModel.showRestartAlert = true
                }
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack{
                    VStack{
                        Text("\(player1) score")
                            .font(.headline)
                             Text("\(viewModel.player1win)")
                    }
                    Spacer()
                             VStack{
                                 Text("\(player2) score")
                                    .font(.headline)
                                      Text("\(viewModel.player2win)")
                             }
                }
                .padding()
                .alert("", isPresented: $viewModel.showRestartAlert) {
                    Button {
                        viewModel.restart()
                    } label: {
                        Text("Restart game")
                    }
                    
                    Button (role: .destructive){
                        viewModel.resetScore()
                    } label: {
                        Text("Restart and reset score")
                    }


                } message: {
                    Text("Do you want to?")
                }

            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.large)
            
    }
}

#Preview {
    NavigationStack{
        TicTacView(player1: "Player 1", player2: "Player 2")
    }
}
