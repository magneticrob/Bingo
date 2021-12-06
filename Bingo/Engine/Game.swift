//
//  Game.swift
//  Bingo
//
//  Created by Rob Baker on 04/12/2021.
//

import Foundation

class Game {
    let boards: [Board]
    var calledNumbers: [Int] = []
    var numbersToCall: [Int] = [30,35,8,2,39,37,72,7,81,41,25,46,56,18,89,70,0,15,84,75,88,67,42,44,94,71,79,65,58,52,96,83,54,29,14,95,66,61,97,68,57,90,55,32,17,47,20,98,1,69,63,62,31,86,77,85,87,93,26,40,24,19,48,76,73,49,34,45,82,22,80,78,23,6,59,91,64,43,21,51,13,3,53,99,4,28,33,74,12,9,36,50,60,11,27,10,5,16,92,38]
    var numberToCallIndex: Int = 0
    var winningBoards: [Board] = []
    
    init(input: [[[Int]]]) {
        print("====================================")
        print(" STARTING ")
        print("====================================")
        self.boards = Game.boardsFrom(input)
        
        print("====================================")
        print("Initialised with \(boards.count) boards")
        print("====================================")
    }
    
    static func boardsFrom(_ input: [[[Int]]]) -> [Board] {
        var boards: [Board] = []
        for board in input {
            let board = Board(input: board)
            boards.append(board)
        }
        return boards
    }
    
    func start() {
        while !aBoardsHasWon() {
            let calledNumber = callNumber()
            checkBoards(for: calledNumber)
        }
        
        if aBoardsHasWon() {
            let winningBoard = winningBoard()
            print("WINNING BOARD: \(winningBoard.description)")
            print("LAST WINNING NUMBER: \(calledNumbers.last!)")
            print("SUM OF WINNING BOARD'S UNCALLED NUMBERS: \(winningBoard.sumOfUncalledNumbers())")
        }
    }
    
    @discardableResult
    func callNumber() -> Int {
        // Uncomment this for real bingo
//        let randomInt = Int.random(in: 1...99)
//        guard !calledNumbers.contains(randomInt) else {
//            callNumber()
//            return -1
//        }
        
        guard numberToCallIndex < numbersToCall.count else {
            print("====================================")
            print("ERROR - WE CALLED ALL THE NUMBERS")
            print("====================================")
            return -1
        }
        
        let randomInt = numbersToCall[numberToCallIndex]
        
        print("====================================")
        print("CALLING \(randomInt) WHICH IS INDEX \(numberToCallIndex)")
        print("====================================")
        
        numberToCallIndex += 1
        calledNumbers.append(randomInt)
        return randomInt
    }
    
    func checkBoards(for number: Int) {
        boards.forEach { board in
            if !board.hasWon() {
                board.checkForNumber(number: number)
            } else {
                if !board.hasBeenAddedToListOfWinningBoards {
                    winningBoards.append(board)
                    board.hasBeenAddedToListOfWinningBoards = true
                }
            }
        }
    }
    
    func aBoardsHasWon() -> Bool {
        guard calledNumbers.count != numbersToCall.count else { return true }
        return boards.filter({$0.hasWon()}).count > 0
    }
    
    func winningBoard() -> Board {
        return boards.filter({$0.hasWon()}).last!
    }
}
