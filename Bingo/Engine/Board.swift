//
//  Board.swift
//  Bingo
//
//  Created by Rob Baker on 04/12/2021.
//

import Foundation

class Board {
    var columns: Int = 0
    var rows: [[Int]] = []
    var hitIndexPaths: [IndexPath] = []
    var hitNumbers: [Int] = []
    var hasBeenAddedToListOfWinningBoards: Bool = false
    
    var description : String {
        var string: String = ""
        string += "Board(columns: \(columns), rows: \(rows.count))\n"
        for row in rows {
            string += "              ["
            for number in row {
                if hitNumbers.contains(number) {
                    string += "\(number)*, "
                } else {
                    string += "\(number), "
                }
            }
            string += "],\n"
        }
        string += ")"
        return string
    }
    
    init(input: [[Int]]) {
        guard let firstRow = input.first else { fatalError("Input msut contain at least one row")}
        columns = firstRow.count
        rows = input
        
        print("====================================")
        print("Initialised board with \(columns) columns and \(rows.count) rows")
    }
    
    func checkForNumber(number: Int) {
        guard !hasWon() else {
            print("Already won, not trying")
            return
        }
        
        for (rowIndex, row) in rows.enumerated() {
            for (columnIndex, currentNumberToCheck) in row.enumerated() {
                if number == currentNumberToCheck {
                    let hitIndexPath = IndexPath(row: rowIndex, section: columnIndex)
                    hitNumbers.append(number)
                    hitIndexPaths.append(hitIndexPath)
                    
                    print("******************** WE HIT ******************** ")
                    print("******* \(number) matches number at *************")
                    print("*** Index Path: \(rowIndex), \(columnIndex), which is: \(numberForIndexPath(indexPath: hitIndexPath)) *****")
                    print("******************** BOARD ******************** ")
                    print("\(self.description)")
                    print("******************** END BOARD ******************** ")
                }
            }
        }
    }
    
    func numberForIndexPath(indexPath: IndexPath) -> Int {
        return rows[indexPath.row][indexPath.section]
    }
    
    func hasWon() -> Bool {
        
        var didWin: Bool = false
        for index in 0...(columns - 1) {
            // Have we got 5 index paths all with the same row? (Horizontal Win)
            if hitIndexPaths.filter({$0.row == index}).count == columns {
                didWin = true
            }
            
            // Have we got 5 index paths all with the same column? (vertical Win)
            if hitIndexPaths.filter({$0.section == index}).count == columns {
                didWin = true
            }
        }
        
        return didWin
    }
    
    func sumOfUncalledNumbers() -> Int {
        let boardNumbers = rows.flatMap({$0})
        let uncalledNumbers = boardNumbers.filter({!hitNumbers.contains($0)})
        
        return uncalledNumbers.reduce(0, +)
    }
}
