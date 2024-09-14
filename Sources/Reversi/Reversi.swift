
//
//  main.swift
//  OCProgram
//  Using version 0.0.8 of OCGui
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
            // self.playerTurn = !self.playerTurn
        }

    }
    mutating func reset(){
        /// resets the board
        self.initialise()
        self.setStartBoard()
        self.playerTurn = true
        self.gameOver = false
        self.gameWinner = 0
    }
}

func easyAI(board: Board) -> [Int]{
    let legalMoves = board.getLegalMoves()
    return legalMoves[Int.random(in: 0..<legalMoves.count)]
}

func getAIMove(board: Board, aiNumber: Int) -> [Int]{
    /// returns the move of the ai at difficulty aiNumber. If not a valid ai then return [-1, -1]
    switch aiNumber{
            // easy ai
        case 1:
            print("easy ai")
            return easyAIGetBestMove(board: board)
        case 2:
            print("medium ai")
            return mediumAIGetBestMove(board: board)
        case 3:
            // hard ai
            print("hard ai")
            return hardAIGetBestMove(board: board)
        // player vs player
        default:
            print("player vs player")
            return [-1, -1]
    }
}

// AI Mode
var aiMode: Int = 0

class ReversiApp : OCApp {
    // Button for resetting the board.
    let ResetButton: OCButton = OCButton(text: "Reset Board")

    // Label for displaying the piece counts.
    var pieceCountLabel: OCLabel = OCLabel(text: "")

    // Label for displaying the winner.
    var winnerStatusLabel: OCLabel = OCLabel(text: "")

    // Dropdown for changing modes.
    let ModeDropDown: OCDropDown = OCDropDown(fromArray: ["Versus", "Easy", "Medium", "Hard"])

    // Button for opening the rules.
    let RulesButton: OCButton = OCButton(text: "Rules")

    // Text
    var rulesText: OCLabel = OCLabel(text: "")

    // Dialog for displaying rules.
    let RulesDialog: OCDialog = OCDialog(title: "Rules", message: "")

    let Rules: OCImageView = OCImageView(filename: "images/Reversi_Rules.png")

    // let Rules1: OCImageView = OCImageView(filename: "images/Reversi_0007.png")

    // let Rules2: OCImageView = OCImageView(filename: "images/Reversi_0008.png")

    // let Rules3: OCImageView = OCImageView(filename: "images/Reversi_0009.png")

    var rulesShown: Bool = false

    var rules: OCVBox = OCVBox(controls: [])

    var colourBlind: Bool = false

    var colourSwitch: OCImageView = OCImageView(filename: "images/ColourBlindRGB.png")

    struct Tile{
        let x: Int
        let y: Int
        var image: OCImageView
        var app: ReversiApp

        func onPress(tile: OCControlClickable){
            print("was clicked on \(self.x), \(self.y)")
            if aiMode == 1 || aiMode == 2 || aiMode == 3 {
                let PlayerLegalMove = self.app.board.isLegalMove(x: x, y: y, whitePiece: self.app.board.playerTurn)
                if (self.app.board.isLegalMove(x: x, y: y, whitePiece: self.app.board.playerTurn)){
                    self.app.board.doMove(x: x, y: y)
                }
                if PlayerLegalMove == true {
                let AiMove = getAIMove(board: self.app.board, aiNumber: aiMode)
                self.app.board.doMove(x: AiMove[0], y: AiMove[1])
                }
            }
            else {
                if (self.app.board.isLegalMove(x: x, y: y, whitePiece: self.app.board.playerTurn)){
                    self.app.board.doMove(x: x, y: y)
                }
            }
            self.app.redrawTiles()
            app.board.checkIsGameOver()
            let GameStatus: Bool = app.board.isGameOver()
            if GameStatus == true {
                if app.colourBlind == true {
                    if app.board.gameWinner == 0 {
                    app.winnerStatusLabel.text = "Draw!"
                    }
                    else if app.board.gameWinner == 1 {
                        app.winnerStatusLabel.text = "Black Wins!"
                    }
                    else if app.board.gameWinner == 2 {
                        app.winnerStatusLabel.text = "White Wins!"
                    }
                }
                else if app.colourBlind == false {
                    if app.board.gameWinner == 0 {
                    app.winnerStatusLabel.text = "Draw!"
                    }
                    else if app.board.gameWinner == 1 {
                        app.winnerStatusLabel.text = "Green Wins!"
                    }
                    else if app.board.gameWinner == 2 {
                        app.winnerStatusLabel.text = "Red Wins!"
                    }
                }
            }
        }
    }

    var board: Board = Board()
    func resetBoard(){
        self.board.initialise()
        self.board.setStartBoard()
    }

    var tiles: [[Tile]] = []
    func setupTiles(){
        // self.tiles: [[Tile]] = []
        for x in 0..<8{
            var row: [Tile] = []
            for y in 0..<8{
                row.append(Tile(x: x, y: y, image: OCImageView(filename: "images/SquareOutline.png"), app: self))
            }
            self.tiles.append(row)
        }
    }

    func redrawTiles(){
        // Counter for tiles.
        var whitePieceCount = 0
        var blackPieceCount = 0
        for x in 0..<self.board.colum{
            for y in 0..<self.board.rows{
                let pieceType = self.board.getPieceAt(x: x, y: y)
                if (pieceType == 1){
                    // white piece
                    whitePieceCount += 1
                }
                if (pieceType == 2){
                    // black piece
                    blackPieceCount += 1
                }
            }
        }

        for x in 0..<8{
            for y in 0..<8{
                let pieceType = self.board.getPieceAt(x: x, y: y)
                let tile = self.tiles[x][y]
                if colourBlind == true {
                    self.pieceCountLabel.text = "Black: \(whitePieceCount)  White: \(blackPieceCount)"
                    if (pieceType == 0){
                    // empty
                    tile.image.filename = "images/SquareOutline.png"
                    }
                    else if (pieceType == 1){
                        // green/player1
                        tile.image.filename = "images/BlackLogo.png"
                    }
                    else if (pieceType == 2){
                        // red/player 2
                        tile.image.filename = "images/WhiteLogo.png"
                    }
                }
                else if colourBlind == false {
                    self.pieceCountLabel.text = "Green: \(whitePieceCount)  Red: \(blackPieceCount)"
                    if (pieceType == 0){
                    // empty
                    tile.image.filename = "images/SquareOutline.png"
                    }
                    else if (pieceType == 1){
                        // green/player1
                        tile.image.filename = "images/GreenLogo.png"
                    }
                    else if (pieceType == 2){
                        // red/player 2
                        tile.image.filename = "images/RedLogo.png"
                    }
                }
            }
        }


        print("White: \(whitePieceCount)  Black: \(blackPieceCount)")
    }
    


    func Input(prompt: String) -> String {
        print(prompt, terminator: ": ")
        if let userInput = readLine() { return userInput }
        return ""
    }

    /// Event function for when the "ResetButton" button is pressed.
    func ResetButtonPressed(button: OCControlClickable) {
        board.reset()
        redrawTiles()
        winnerStatusLabel.text = ""
    }

    /// Event function for when the "RulesButton" button is pressed.
    func RulesButtonPressed(button: OCControlClickable) {
        if rulesShown == false {
            Rules.visible = true
            // Rules1.visible = true
            // Rules2.visible = true
            // Rules3.visible = true
            rules.visible = true
            rulesShown = true
        }
        else if rulesShown == true {
            Rules.visible = false
            // Rules1.visible = false
            // Rules2.visible = false
            // Rules3.visible = false
            rules.visible = false
            rulesShown = false
        }
        
    }

    func ModeDropDownChanged(dropDown: any OCControlChangeable, item: OCDropDownItem) {
        board.reset()
        redrawTiles()
        winnerStatusLabel.text = ""
        let SelectedMode = ModeDropDown.selectedItem!
        if SelectedMode.text == "Easy" {
            aiMode = 1
        }
        else if SelectedMode.text == "Medium" {
            aiMode = 2
        }
        else if SelectedMode.text == "Hard" {
            aiMode = 3
        }
    }

    // /// Event function for when the "ColourSwitch" button is pressed.
    // func ColourSwitchPressed(button: OCControlClickable) {
    //     var whitePieceCount = 0
    //     var blackPieceCount = 0
    //     for x in 0..<self.board.colum{
    //         for y in 0..<self.board.rows{
    //             let pieceType = self.board.getPieceAt(x: x, y: y)
    //             if (pieceType == 1){
    //                 // white piece
    //                 whitePieceCount += 1
    //             }
    //             if (pieceType == 2){
    //                 // black piece
    //                 blackPieceCount += 1
    //             }
    //         }
    //     }
    //     if colourBlind == false {
    //         colourSwitch.filename = "images/ColourBlindBW.png"
    //         pieceCountLabel.text = "Black: \(whitePieceCount)  White: \(blackPieceCount)"
    //         colourBlind = true
    //     }
    //     else if colourBlind == true {
    //         colourSwitch.filename = "images/ColourBlindRGB.png"
    //         pieceCountLabel.text = "Green: \(whitePieceCount)  Red: \(blackPieceCount)"
    //         colourBlind = false
    //     }
    //     redrawTiles()
    // }


    override open func main(app: OCAppDelegate) -> OCControl {

        //self.RulesDialog.addField(key: "image", field: OCImageView(filename: "images/fun.png"))
        

        // Event for when the "ResetButton" button is pressed.
        self.ResetButton.onClick(self.ResetButtonPressed)
        
        // Event for when the "RulesButton" button is pressed.
        self.RulesButton.onClick(self.RulesButtonPressed)

        self.ModeDropDown.onChange(self.ModeDropDownChanged)

        // Event for when the "colourSwitch" button is pressed.
        // self.colourSwitch.onClick(ColourSwitchPressed)

        // self.RulesButton.onClick({ button in
        //     self.RulesDialog.show(in: app)
        // })

        Rules.visible = false
        // Rules1.visible = false
        // Rules2.visible = false
        // Rules3.visible = false

        self.RulesDialog.onConfirm({ button in
            self.rulesText.text = "Ok"
            self.RulesDialog.hide()
        })

        self.RulesDialog.onCancel({ button in
            self.rulesText.text = "Cancel"
            self.RulesDialog.hide()
        })


        for row in self.tiles{
            for tile in row{
                tile.image.onClick(tile.onPress)
            }
        }

        var buttonRows: [OCHBox] = []
        for row in 0..<8{
            var controlsRow: [OCControl] = []
            for tile in self.tiles[row]{
                controlsRow.append(tile.image)
            }
            buttonRows.append(OCHBox(controls: controlsRow))
        }
        rules = OCVBox(controls: [Rules])
        let Grid = OCVBox(controls: buttonRows)
        let ControlRow = OCHBox(controls: [RulesButton, ResetButton, ModeDropDown, colourSwitch])
        let Program = OCVBox(controls: [pieceCountLabel, winnerStatusLabel, Grid, ControlRow])
        let ProgramFull = OCVBox(controls: [Program, rules])
        Grid.setStyle(OCStyle.backgroundColor(OCColor.antiqueWhite))
        
        func ColourSwitchPressed(button: OCControlClickable) {
        var whitePieceCount = 0
        var blackPieceCount = 0
        for x in 0..<self.board.colum{
            for y in 0..<self.board.rows{
                let pieceType = self.board.getPieceAt(x: x, y: y)
                if (pieceType == 1){
                    // white piece
                    whitePieceCount += 1
                }
                if (pieceType == 2){
                    // black piece
                    blackPieceCount += 1
                }
            }
        }
        if self.colourBlind == false {
            self.colourSwitch.filename = "images/ColourBlindBW.png"
            self.pieceCountLabel.text = "Black: \(whitePieceCount)  White: \(blackPieceCount)"
            self.colourBlind = true
            Grid.setStyle(OCStyle.backgroundColor(OCColor.gray))
        }
        else if self.colourBlind == true {
            self.colourSwitch.filename = "images/ColourBlindRGB.png"
            self.pieceCountLabel.text = "Green: \(whitePieceCount)  Red: \(blackPieceCount)"
            self.colourBlind = false
            Grid.setStyle(OCStyle.backgroundColor(OCColor.antiqueWhite))
        }
        redrawTiles()
    }
    self.colourSwitch.onClick(ColourSwitchPressed)
        rules.visible = false
        return ProgramFull
    }
}
