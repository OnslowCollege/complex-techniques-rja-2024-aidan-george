
//
//  main.swift
//  OCProgram
//
//  Created by Kellan Van Koughnet on 1/01/24.
//

import Foundation
import OCGUI

class TestApp : OCApp {
    // Buttons used in the gui.
    // var tileAA = OCButton(text: "")
    // var tileAB = OCButton(text: "nhkhkijliefwef")
    // var tileAC = OCButton(text: "")
    // var tileAD = OCButton(text: "")
    // var tileAE = OCButton(text: "")
    // var tileAF = OCButton(text: "")
    // var tileAG = OCButton(text: "")
    // var tileAH = OCButton(text: "")
    // var tileBA = OCButton(text: "")
    // var tileBB = OCButton(text: "")
    // var tileBC = OCButton(text: "")
    // var tileBD = OCButton(text: "")
    // var tileBE = OCButton(text: "")
    // var tileBF = OCButton(text: "")
    // var tileBG = OCButton(text: "")
    // var tileBH = OCButton(text: "")
    // var tileCA = OCButton(text: "")
    // var tileCB = OCButton(text: "")
    // var tileCC = OCButton(text: "")
    // var tileCD = OCButton(text: "")
    // var tileCE = OCButton(text: "")
    // var tileCF = OCButton(text: "")
    // var tileCG = OCButton(text: "")
    // var tileCH = OCButton(text: "")
    // var tileDA = OCButton(text: "")
    // var tileDB = OCButton(text: "")
    // var tileDC = OCButton(text: "")
    // var tileDD = OCButton(text: "")
    // var tileDE = OCButton(text: "")
    // var tileDF = OCButton(text: "")
    // var tileDG = OCButton(text: "")
    // var tileDH = OCButton(text: "")
    // var tileEA = OCButton(text: "")
    // var tileEB = OCButton(text: "")
    // var tileEC = OCButton(text: "")
    // var tileED = OCButton(text: "")
    // var tileEE = OCButton(text: "")
    // var tileEF = OCButton(text: "")
    // var tileEG = OCButton(text: "")
    // var tileEH = OCButton(text: "")
    // var tileFA = OCButton(text: "")
    // var tileFB = OCButton(text: "")
    // var tileFC = OCButton(text: "")
    // var tileFD = OCButton(text: "")
    // var tileFE = OCButton(text: "")
    // var tileFF = OCButton(text: "")
    // var tileFG = OCButton(text: "")
    // var tileFH = OCButton(text: "")
    // var tileGA = OCButton(text: "")
    // var tileGB = OCButton(text: "")
    // var tileGC = OCButton(text: "")
    // var tileGD = OCButton(text: "")
    // var tileGE = OCButton(text: "")
    // var tileGF = OCButton(text: "")
    // var tileGG = OCButton(text: "")
    // var tileGH = OCButton(text: "")
    // var tileHA = OCButton(text: "")
    // var tileHB = OCButton(text: "")
    // var tileHC = OCButton(text: "")
    // var tileHD = OCButton(text: "")
    // var tileHE = OCButton(text: "")
    // var tileHF = OCButton(text: "")
    // var tileHG = OCButton(text: "")
    // var tileHH = OCButton(text: "")

    var buttons: [[OCButton]] = []
    for _ in 0..<8{
        var buttonRow: [OCButton] = []
        for _ in 0..<8{
            buttonRow.append(OCButton(text: ""))
        }
        buttons.append(buttonRow)
    }

    override open func main(app: OCAppDelegate) -> OCControl {
        // Returns the fully laid out GUI.
        var buttonRows: [OCControl] = []
        // let TileButtonsRowOne = OCHBox(controls: [tileAA, tileAB, tileAC, tileAD, tileAE, tileAF, tileAG, tileAH])
        // let TileButtonsRowTwo = OCHBox(controls: [tileBA, tileBB, tileBC, tileBD, tileBE, tileBF, tileBG, tileBH])
        // let TileButtonsRowThree = OCHBox(controls: [tileCA, tileCB, tileCC, tileCD, tileCE, tileCF, tileCG, tileCH])
        // let TileButtonsRowFour = OCHBox(controls: [tileDA, tileDB, tileDC, tileDD, tileDE, tileDF, tileDG, tileDH])
        // let TileButtonsRowFive = OCHBox(controls: [tileEA, tileEB, tileEC, tileED, tileEE, tileEF, tileEG, tileEH])
        // let TileButtonsRowSix = OCHBox(controls: [tileFA, tileFB, tileFC, tileFD, tileFE, tileFF, tileFG, tileFH])
        // let TileButtonsRowSeven = OCHBox(controls: [tileGA, tileGB, tileGC, tileGD, tileGE, tileGF, tileGG, tileGH])
        // let TileButtonsRowEight = OCHBox(controls: [tileHA, tileHB, tileHC, tileHD, tileHE, tileHF, tileHG, tileHH])
        // let Grid = OCVBox(controls: [TileButtonsRowOne, TileButtonsRowTwo, TileButtonsRowThree, TileButtonsRowFour, TileButtonsRowFive, TileButtonsRowSix, TileButtonsRowSeven, TileButtonsRowEight])
        for row in 0..<8{
            buttonRows.append(OCHBox(controls: buttons[row]))
        }
        let Grid = OCVBox(controls: buttonRows)
        return Grid
    }
}

TestApp().start()
