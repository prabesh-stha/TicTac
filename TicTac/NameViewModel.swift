//
//  NameViewModel.swift
//  TicTac
//
//  Created by Prabesh Shrestha on 25/08/2024.
//

import Foundation
final class NameViewModel: ObservableObject{
    @Published var player1: String = ""
    @Published var player2: String = ""
}
