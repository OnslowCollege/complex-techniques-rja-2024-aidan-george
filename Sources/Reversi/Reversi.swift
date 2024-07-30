
//
//  main.swift
//  OCProgram
//
//  Created by Kellan Van Koughnet on 1/01/24.
//

import Foundation
import OCGUI

struct Board{
    let rows = 8
    let colum = 8
    var grid: [[Int]] = [[]]// = Array(repeating: Array(repeating: 0, count: colum), count:
    var playerTurn: Bool = true
    var gameOver = false
    var gameWinner = 0 // 0 if drawn/not over, 1 if white won, 2 if black won

    mutating func initialise(){
        self.grid = Array(repeating: Array(repeating: 0, count: colum), count: rows)
    }

    mutating func setStartBoard(){
        self.placePiece(x: 3, y: 3, whitePiece: true)
        self.placePiece(x: 4, y: 3, whitePiece: false)
        self.placePiece(x: 3, y: 4, whitePiece: false)
        self.placePiece(x: 4, y: 4, whitePiece: true)
    }

    mutating func placePiece(x: Int, y: Int, whitePiece: Bool){
        if (!(0 <= x && x < self.colum && 0 <= y && y < self.rows)){
            return
        }
        let piece: Int
        if (whitePiece){
            piece = 1
        }
        else {
            piece = 2
        }
        self.grid[y][x] = piece
    }

    func getPieceAt(x: Int, y: Int) -> Int{
        return self.grid[y][x]
    }

    // func printBoard(){
    //     let pieceSymbols = ["⬛", "🟦", "🟥"]
    //     for row in grid{
    //         var text = ""
    //         for piece in row{
    //             text += pieceSymbols[piece] + " "
    //         }
    //         print(text)
    //     }

    //     if (self.isGameOver()){
    //         print("Game Over, \(pieceSymbols[self.gameWinner]) won")
    //     }
    // }

    mutating func changeTurn(){
        self.playerTurn = !self.playerTurn
    }
        
    func willFlipInDirection(x: Int, y: Int, dx: Int, dy: Int, whitePiece: Bool) -> Bool{
        /// checks whether a piece (white if whitePiece else black) placed at x, y will flip pieces in direction dx, dy
        
        var vx = x // virtual position to check
        var vy = y
        // loop through spaces in the direction dx dy
        for i in 0..<max(self.rows, self.colum){
            vx += dx
            vy += dy

            if (0 > vx  || self.colum <= vx || 0 > vy || self.rows <= vy){ return false}


            let piece = self.getPieceAt(x: vx , y: vy)
            if (piece == 0){return false}
            if ((piece == 1 && whitePiece) || (piece == 2 && !whitePiece)){
                if (i == 0){
                    return false
                }
                return true
            }
        }

        return false
    }

    func willFlip(x: Int, y: Int, whitePiece: Bool) -> Bool{
        for dx in -1..<2{
            for dy in -1..<2{
                if (dx != 0 || dy != 0){
                    if (willFlipInDirection(x: x, y: y, dx: dx, dy: dy, whitePiece: whitePiece)){
                        return true
                    }
                }
            }
        }
        return false
    }

    mutating func flipPiece(x: Int, y: Int){
        /// flips the piece at x, y
        let piece = self.getPieceAt(x: x, y: y)
        // if its a white piece then replace it with a black piece and vice versa
        self.grid[y][x] = (piece == 1) ? 2 : 1
    }

    mutating func doFlipsInDirection(x: Int, y: Int, dx: Int, dy: Int, whitePiece: Bool){
        /// flips all the pieces from x, y, in the direction dx, dy, stops when cant flip the piece
        var vx = x // stores the position its checking
        var vy = y
        for _ in 0..<max(self.rows, self.colum){
            vx += dx
            vy += dy

            // if out of board then return
            if (0 > vx  || self.colum <= vx || 0 > vy || self.rows <= vy){ return}


            let piece = self.getPieceAt(x: vx , y: vy)
            // if piece is not the opposite colour then return
            if (piece == 0 || ((piece == 1 && whitePiece) || (piece == 2 && !whitePiece))){
                return
            }

            self.flipPiece(x: vx, y: vy)
        }
    }

    mutating func doFlips(x: Int, y: Int, whitePiece: Bool){
        for dx in -1..<2{
            for dy in -1..<2{
                if (dx != 0 || dy != 0){
                    if (willFlipInDirection(x: x, y: y, dx: dx, dy: dy, whitePiece: whitePiece)){
                        // flips pieces because it will flip in that directino
                        self.doFlipsInDirection(x: x, y: y, dx: dx, dy: dy, whitePiece: whitePiece)
                    }
                }
            }
        }
    }

    func isLegalMove(x: Int, y: Int, whitePiece: Bool) -> Bool{
        return willFlip(x: x, y: y, whitePiece: whitePiece) && self.getPieceAt(x: x, y: y) == 0
    }

    func getLegalMoves() -> [[Int]]{
        var legalMoves: [[Int]] = []
        for x in 0..<self.colum{
            for y in 0..<self.rows{
                if (isLegalMove(x: x, y: y, whitePiece: self.playerTurn)){
                    // is a legal move
                    legalMoves.append([x, y])
                }
            }
        }
        return legalMoves
    }

    mutating func checkIsGameOver(){
        /// checks if the game is over. updates the isGameOver method to the correct value and makes gameWinner the correct valeu.
        
        // check if there are any legal moves
        let legalMoves = self.getLegalMoves()
        if (legalMoves.count == 0){
            // no legal moves so need to check whether its actually over or if it should just skip
            var pieceCount = 0 // keeps track of how many pieces are on the board
            var whitePieceCount = 0
            var blackPieceCount = 0
            // look at each square and add values to counts
            for x in 0..<self.colum{
                for y in 0..<self.rows{
                    let piece = self.getPieceAt(x: x, y: y)
                    if (piece == 1){
                        // add 1 to white piece count and peice count
                        pieceCount += 1
                        whitePieceCount += 1
                    }
                    if (piece == 2){
                        // add 1 to black piece count and peice count
                        pieceCount += 1
                        blackPieceCount += 1
                    }
                }
            }

            // if piece count is row*column then the board is full
            if (pieceCount == self.rows*self.colum){
                // set gameWinner to the winner and gameOver to true
                self.gameOver = true
                // if white has more pieces
                if (whitePieceCount > blackPieceCount){
                    self.gameWinner = 1
                }
                // if black has more pieces
                else if (whitePieceCount < blackPieceCount){
                    self.gameWinner = 2
                }
                // if neither is greater then its a draw
                else{
                    self.gameWinner = 0
                }
            }
            else if (whitePieceCount == 0){
                // black wins cause white has 0 pieces
                self.gameOver = true
                self.gameWinner = 2
            }
            else if (blackPieceCount == 0){
                // white wins cause black has 0 pieces
                self.gameOver = true
                self.gameWinner = 1
            }
            else {
                // need to check if the other player can play. if they cant then whoever has more tiles wins
                // pretend is the next player who plays
                self.playerTurn = !self.playerTurn

                let nextTurnLegalMoves = self.getLegalMoves()

                // switch to the original players turn so nothing else will get messed up
                self.playerTurn = !self.playerTurn

                // if theres no legal moves for the next player then its over
                if (nextTurnLegalMoves.count == 0){
                    // whoever has more tiles wins
                    // set gameWinner to the winner and gameOver to true
                    self.gameOver = true
                    // if white has more pieces
                    if (whitePieceCount > blackPieceCount){
                        self.gameWinner = 1
                    }
                    // if black has more pieces
                    else if (whitePieceCount < blackPieceCount){
                        self.gameWinner = 2
                    }
                    // if neither is greater then its a draw
                    else{
                        self.gameWinner = 0
                    }
                }
            }
        }

        // if not already over and neither player can play then person with more spaces wins
    }

    func isGameOver() -> Bool{
        return self.gameOver
    }

    mutating func doMove(x: Int, y: Int){
        // if game is over then skip
        if (self.isGameOver()){
            return
        }
        // if isnt a legal move then skip
        if (!isLegalMove(x: x, y: y, whitePiece: self.playerTurn)){
            return
        }

        // flips pieces
        self.doFlips(x: x, y: y, whitePiece: self.playerTurn)

        // place the piece
        self.placePiece(x: x, y: y, whitePiece: self.playerTurn)

        // change players turn
        self.playerTurn = !self.playerTurn

        // check if game is over
        self.checkIsGameOver()

        // check if there are legal moves and game is not over
        let legalMoves = self.getLegalMoves()
        if (!self.isGameOver() && legalMoves.count == 0){
            // there are no legal moves so skip this players turn
            self.playerTurn = !self.playerTurn
        }

    }
}

func easyAI(board: Board) -> [Int]{
    let legalMoves = board.getLegalMoves()
    return legalMoves[Int.random(in: 0..<legalMoves.count)]
}

var userX = 0
var userY = 0
var whiteUser = true
var squareInputX = 0
var squareInputY = 0
var board = Board()
board.initialise()
board.setStartBoard()
while true{
    board.printBoard()
    let move = easyAI(board: board)
    userX = move[0]
    userY = move[1]
    // while true{
    //     squareInputX = 0
    //     squareInputX = Int(Input(prompt: "0 - 7 (Z)"))!
    //     squareInputY = Int(Input(prompt: "0 - 7 (X)"))!

    //     if squareInputX >= 0 && squareInputX <= 7 && squareInputY >= 0 && squareInputY <= 7{
    //         userX = squareInputX
    //         userY = squareInputY
    //         break
    //     }
    //     else{
    //         print("stupid")
            
    //     }
    // }

    // board.placePiece(x: userX, y: userY, whitePiece: board.playerTurn)
    // board.changeTurn()
    board.doMove(x: userX, y: userY)
    print()
}
board.printBoard()


class ReversiApp : OCApp {
    struct Tile{
        let x: Int
        let y: Int
        var image: OCImageView

        func onPress(tile: OCControlClickable){
            print("was clciked on \(self.x), \(self.y)")
        }
    }

    var tiles: [[Tile]] = []
    func setupTiles(){
        // self.tiles: [[Tile]] = []
        for x in 0..<8{
            var row: [Tile] = []
            for y in 0..<8{
                row.append(Tile(x: x, y: y, image: OCImageView(filename: "images/SquareOutline.png")))
            }
            self.tiles.append(row)
        }
    }
    // Buttons used in the gui.
    // var tileAA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileAH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileBH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileCH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileDH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileED: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileEH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileFH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileGH: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHA: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHB: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHC: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHD: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHE: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHF: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHG: OCImageView = OCImageView(filename: "images/SquareOutline.png")
    // var tileHH: OCImageView = OCImageView(filename: "images/SquareOutline.png")

    func Input(prompt: String) -> String {
        print(prompt, terminator: ": ")
        if let userInput = readLine() { return userInput }
        return ""
    }

    // let TilePositions: [String: [Int]] = ["tileAA": [0, 0], "tileAB": [1, 0], "tileAC": [2, 0], "tileAD": [3, 0], "tileAE": [4, 0], "tileAF": [5, 0], "tileAG": [6, 0], "tileAH": [7, 0], "tileBA": [0, 1], "tileBB": [1, 1], "tileBC": [2, 1], "tileBD": [3, 1], "tileBE": [4, 1], "tileBF": [5, 1], "tileBG": [6, 1], "tileBH": [7, 1], "tileCA": [0, 2], "tileCB": [1, 2], "tileCC": [2, 2], "tileCD": [3, 2], "tileCE": [4, 2], "tileCF": [5, 2], "tileCG": [6, 2], "tileCH": [7, 2], "tileDA": [0, 3], "tileDB": [1, 3], "tileDC": [2, 3], "tileDD": [3, 3], "tileDE": [4, 3], "tileDF": [5, 3], "tileDG": [6, 3], "tileDH": [7, 3], "tileEA": [0, 4], "tileEB": [1, 4], "tileEC": [2, 4], "tileED": [3, 4], "tileEE": [4, 4], "tileEF": [5, 4], "tileEG": [6, 4], "tileEH": [7, 4], "tileFA": [0, 5], "tileFB": [1, 5], "tileFC": [2, 5], "tileFD": [3, 5], "tileFE": [4, 5], "tileFF": [5, 5], "tileFG": [6, 5], "tileFH": [7, 5], "tileGA": [0, 6], "tileGB": [1, 6], "tileGC": [2, 6], "tileGD": [3, 6], "tileGE": [4, 6], "tileGF": [5, 6], "tileGG": [6, 6], "tileGH": [7, 6], "tileHA": [0, 7], "tileHB": [1, 7], "tileHC": [2, 7], "tileHD": [3, 7], "tileHE": [4, 7], "tileHF": [5, 7], "tileHG": [6, 7], "tileHH": [7, 7]]

    /// Event function for when the "next" button is pressed.
    func tilePressed(tile: OCControlClickable) {
        // If a flash card has not been shown previous to this, will assume the user is starting the flashcard app.
        tileAA.filename = "images/SquareOutline.png"
        }

    // var buttons: [[OCImageView]] = []
    // for _ in 0..<8{
    //     var buttonRow: [OCImageView] = []
    //     for _ in 0..<8{
    //         buttonRow.append(OCImageView(filename: "images/SquareOutline.png"))
    //     }
    //     buttons.append(buttonRow)
    // }

    override open func main(app: OCAppDelegate) -> OCControl {
        // Returns the fully laid out GUI.
        // var buttonRows: [OCControl] = []

        for row in self.tiles{
            for tile in row{
                tile.image.onClick(tile.onPress)
            }
        }

        // self.tileAA.onClick(self.tilePressed)
        // self.tileAB.onClick(self.tilePressed)
        // self.tileAC.onClick(self.tilePressed)
        // self.tileAD.onClick(self.tilePressed)
        // self.tileAE.onClick(self.tilePressed)
        // self.tileAF.onClick(self.tilePressed)
        // self.tileAG.onClick(self.tilePressed)
        // self.tileAH.onClick(self.tilePressed)
        // self.tileBA.onClick(self.tilePressed)
        // self.tileBB.onClick(self.tilePressed)
        // self.tileBC.onClick(self.tilePressed)
        // self.tileBB.onClick(self.tilePressed)
        // self.tileBD.onClick(self.tilePressed)
        // self.tileBE.onClick(self.tilePressed)
        // self.tileBF.onClick(self.tilePressed)
        // self.tileBG.onClick(self.tilePressed)
        // self.tileBH.onClick(self.tilePressed)
        // self.tileCA.onClick(self.tilePressed)
        // self.tileCB.onClick(self.tilePressed)
        // self.tileCC.onClick(self.tilePressed)
        // self.tileCD.onClick(self.tilePressed)
        // self.tileCE.onClick(self.tilePressed)
        // self.tileCF.onClick(self.tilePressed)
        // self.tileCG.onClick(self.tilePressed)
        // self.tileCH.onClick(self.tilePressed)
        // self.tileDA.onClick(self.tilePressed)
        // self.tileDB.onClick(self.tilePressed)
        // self.tileDC.onClick(self.tilePressed)
        // self.tileDD.onClick(self.tilePressed)
        // self.tileDE.onClick(self.tilePressed)
        // self.tileDF.onClick(self.tilePressed)
        // self.tileDG.onClick(self.tilePressed)
        // self.tileDH.onClick(self.tilePressed)
        // self.tileEA.onClick(self.tilePressed)
        // self.tileEB.onClick(self.tilePressed)
        // self.tileEC.onClick(self.tilePressed)
        // self.tileED.onClick(self.tilePressed)
        // self.tileEE.onClick(self.tilePressed)
        // self.tileEF.onClick(self.tilePressed)
        // self.tileEG.onClick(self.tilePressed)
        // self.tileEH.onClick(self.tilePressed)
        // self.tileFA.onClick(self.tilePressed)
        // self.tileFB.onClick(self.tilePressed)
        // self.tileFC.onClick(self.tilePressed)
        // self.tileFD.onClick(self.tilePressed)
        // self.tileFE.onClick(self.tilePressed)
        // self.tileFF.onClick(self.tilePressed)
        // self.tileFG.onClick(self.tilePressed)
        // self.tileFH.onClick(self.tilePressed)
        // self.tileGA.onClick(self.tilePressed)
        // self.tileGB.onClick(self.tilePressed)
        // self.tileGC.onClick(self.tilePressed)
        // self.tileGD.onClick(self.tilePressed)
        // self.tileGE.onClick(self.tilePressed)
        // self.tileGF.onClick(self.tilePressed)
        // self.tileGG.onClick(self.tilePressed)
        // self.tileGH.onClick(self.tilePressed)
        // self.tileHA.onClick(self.tilePressed)
        // self.tileHB.onClick(self.tilePressed)
        // self.tileHC.onClick(self.tilePressed)
        // self.tileHD.onClick(self.tilePressed)
        // self.tileHE.onClick(self.tilePressed)
        // self.tileHF.onClick(self.tilePressed)
        // self.tileHG.onClick(self.tilePressed)
        // self.tileHH.onClick(self.tilePressed)


        // let TileButtonsRowOne = OCHBox(controls: [tileAA, tileAB, tileAC, tileAD, tileAE, tileAF, tileAG, tileAH])
        // let TileButtonsRowTwo = OCHBox(controls: [tileBA, tileBB, tileBC, tileBD, tileBE, tileBF, tileBG, tileBH])
        // let TileButtonsRowThree = OCHBox(controls: [tileCA, tileCB, tileCC, tileCD, tileCE, tileCF, tileCG, tileCH])
        // let TileButtonsRowFour = OCHBox(controls: [tileDA, tileDB, tileDC, tileDD, tileDE, tileDF, tileDG, tileDH])
        // let TileButtonsRowFive = OCHBox(controls: [tileEA, tileEB, tileEC, tileED, tileEE, tileEF, tileEG, tileEH])
        // let TileButtonsRowSix = OCHBox(controls: [tileFA, tileFB, tileFC, tileFD, tileFE, tileFF, tileFG, tileFH])
        // let TileButtonsRowSeven = OCHBox(controls: [tileGA, tileGB, tileGC, tileGD, tileGE, tileGF, tileGG, tileGH])
        // let TileButtonsRowEight = OCHBox(controls: [tileHA, tileHB, tileHC, tileHD, tileHE, tileHF, tileHG, tileHH])
        // let Grid = OCVBox(controls: [TileButtonsRowOne, TileButtonsRowTwo, TileButtonsRowThree, TileButtonsRowFour, TileButtonsRowFive, TileButtonsRowSix, TileButtonsRowSeven, TileButtonsRowEight])

        var buttonRows: [OCHBox] = []
        for row in 0..<8{
            var controlsRow: [OCControl] = []
            for tile in self.tiles[row]{
                controlsRow.append(tile.image)
            }
            buttonRows.append(OCHBox(controls: controlsRow))
        }
        let Grid = OCVBox(controls: buttonRows)
        return Grid
    }
}
