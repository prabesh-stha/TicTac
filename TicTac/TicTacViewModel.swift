//
//  TicTacViewModel.swift
//  TicTac
//
//  Created by Prabesh Shrestha on 25/08/2024.
//

import Foundation
import SwiftUI

final class TicTacViewModel: ObservableObject{
    enum Player{
       case none, x, o
        
        var symbol: String {
            switch self{
            case .none:
                return ""
            case .x:
                return "X"
            case .o:
                return "O"
            }
        }
    }
    
    @Published var board: [[Player]] = Array(repeating: Array(repeating: .none, count: 3), count: 3)
    @Published var currentPlayer: Player = .x
    @Published var winner: Player = .none
    
    @Published var showAlert: Bool = false
    @Published var showRestartAlert: Bool = false
    @Published var message: String = ""
    @Published var isDraw: Bool = false
    @Published var player1win = 0
    @Published var player2win = 0

    
    func makeMove(row: Int, col: Int) -> Bool{
        if board[row][col] == .none {
            board[row][col] = currentPlayer
            currentPlayer = currentPlayer == .x ? .o : .x
            return true
        }
        return false
    }
    
    func checkWinner() -> Player{
        
        for row in board{
            if row[0] != .none, row[0] == row[1], row[1] == row[2] {
                return row[0]
            }
        }
        
        for col in 0..<3 {
            if board[0][col] != .none, board[0][col] == board[1][col], board[1][col] == board[2][col]{
                return board[0][col]
            }
        }
        
        if board[0][0] != .none, board[0][0] == board[1][1], board[1][1] == board[2][2]{
            return board[0][0]
        }
        
        if board[0][2] != .none, board[0][2] == board[1][1], board[1][1] == board[2][0]{
            return board[0][2]
        }
        return .none
    }
    
    func checkDraw(winner: Player) -> Bool{
        if winner == .none{
            return !board.flatMap{$0}.contains(.none)
        }
        return false
    }
    
    func restart(){
        board = Array(repeating: Array(repeating: .none, count: 3), count: 3)
        currentPlayer = .x
        
    }
    
    func showScore(winner: Player){
        if winner == .x{
            player1win += 1
        }
        
        if winner == .o{
            player2win += 1
        }
    }
    
    func resetScore(){
        player1win = 0
        player2win = 0
        restart()
    }
    
}
