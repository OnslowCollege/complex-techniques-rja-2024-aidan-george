
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
    var tileAA = OCButton(text: "Test")
    var tileAB = OCButton(text: "Test")
    var tileAC = OCButton(text: "Test")
    var tileAD = OCButton(text: "Test")
    var tileAE = OCButton(text: "Test")
    var tileAF = OCButton(text: "Test")
    var tileAG = OCButton(text: "Test")
    var tileAH = OCButton(text: "Test")
    var tileBA = OCButton(text: "Test")
    var tileBB = OCButton(text: "Test")
    var tileBC = OCButton(text: "Test")
    var tileBD = OCButton(text: "Test")
    var tileBE = OCButton(text: "Test")
    var tileBF = OCButton(text: "Test")
    var tileBG = OCButton(text: "Test")
    var tileBH = OCButton(text: "Test")
    var tileCA = OCButton(text: "Test")
    var tileCB = OCButton(text: "Test")
    var tileCC = OCButton(text: "Test")
    var tileCD = OCButton(text: "Test")
    var tileCE = OCButton(text: "Test")
    var tileCF = OCButton(text: "Test")
    var tileCG = OCButton(text: "Test")
    var tileCH = OCButton(text: "Test")
    var tileDA = OCButton(text: "Test")
    var tileDB = OCButton(text: "Test")
    var tileDC = OCButton(text: "Test")
    var tileDD = OCButton(text: "Test")
    var tileDE = OCButton(text: "Test")
    var tileDF = OCButton(text: "Test")
    var tileDG = OCButton(text: "Test")
    var tileDH = OCButton(text: "Test")
    var tileEA = OCButton(text: "Test")
    var tileEB = OCButton(text: "Test")
    var tileEC = OCButton(text: "Test")
    var tileED = OCButton(text: "Test")
    var tileEE = OCButton(text: "Test")
    var tileEF = OCButton(text: "Test")
    var tileEG = OCButton(text: "Test")
    var tileEH = OCButton(text: "Test")
    var tileFA = OCButton(text: "Test")
    var tileFB = OCButton(text: "Test")
    var tileFC = OCButton(text: "Test")
    var tileFD = OCButton(text: "Test")
    var tileFE = OCButton(text: "Test")
    var tileFF = OCButton(text: "Test")
    var tileFG = OCButton(text: "Test")
    var tileFH = OCButton(text: "Test")
    var tileGA = OCButton(text: "Test")
    var tileGB = OCButton(text: "Test")
    var tileGC = OCButton(text: "Test")
    var tileGD = OCButton(text: "Test")
    var tileGE = OCButton(text: "Test")
    var tileGF = OCButton(text: "Test")
    var tileGG = OCButton(text: "Test")
    var tileGH = OCButton(text: "Test")
    var tileHA = OCButton(text: "Test")
    var tileHB = OCButton(text: "Test")
    var tileHC = OCButton(text: "Test")
    var tileHD = OCButton(text: "Test")
    var tileHE = OCButton(text: "Test")
    var tileHF = OCButton(text: "Test")
    var tileHG = OCButton(text: "Test")
    var tileHH = OCButton(text: "Test")

    override open func main(app: OCAppDelegate) -> OCControl {
        // Returns the fully laid out GUI.
        let TileButtonsRowOne = OCHBox(controls: [tileAA, tileAB, tileAC, tileAD, tileAE, tileAF, tileAG, tileAH])
        let TileButtonsRowTwo = OCHBox(controls: [tileBA, tileBB, tileBC, tileBD, tileBE, tileBF, tileBG, tileBH])
        let TileButtonsRowThree = OCHBox(controls: [tileCA, tileCB, tileCC, tileCD, tileCE, tileCF, tileCG, tileCH])
        let TileButtonsRowFour = OCHBox(controls: [tileDA, tileDB, tileDC, tileDD, tileDE, tileDF, tileDG, tileDH])
        let TileButtonsRowFive = OCHBox(controls: [tileEA, tileEB, tileEC, tileED, tileEE, tileEF, tileEG, tileEH])
        let TileButtonsRowSix = OCHBox(controls: [tileFA, tileFB, tileFC, tileFD, tileFE, tileFF, tileFG, tileFH])
        let TileButtonsRowSeven = OCHBox(controls: [tileGA, tileGB, tileGC, tileGD, tileGE, tileGF, tileGG, tileGH])
        let TileButtonsRowEight = OCHBox(controls: [tileHA, tileHB, tileHC, tileHD, tileHE, tileHF, tileHG, tileHH])
        let Grid = OCVBox(controls: [TileButtonsRowOne, TileButtonsRowTwo, TileButtonsRowThree, TileButtonsRowFour, TileButtonsRowFive, TileButtonsRowSix, TileButtonsRowSeven, TileButtonsRowEight])
        return Grid
    }
}

TestApp().start()
