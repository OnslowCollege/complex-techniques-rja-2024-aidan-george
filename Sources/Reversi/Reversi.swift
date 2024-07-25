
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
    var tileAA = OCImageView(filename: "images/RedDot.png")
    var tileAB = OCImageView(filename: "RedDot.png")
    var tileAC = OCImageView(filename: "RedDot.png")
    var tileAD = OCImageView(filename: "RedDot.png")
    var tileAE = OCImageView(filename: "RedDot.png")
    var tileAF = OCImageView(filename: "RedDot.png")
    var tileAG = OCImageView(filename: "RedDot.png")
    var tileAH = OCImageView(filename: "RedDot.png")
    var tileBA = OCImageView(filename: "RedDot.png")
    var tileBB = OCImageView(filename: "RedDot.png")
    var tileBC = OCImageView(filename: "RedDot.png")
    var tileBD = OCImageView(filename: "RedDot.png")
    var tileBE = OCImageView(filename: "RedDot.png")
    var tileBF = OCImageView(filename: "RedDot.png")
    var tileBG = OCImageView(filename: "RedDot.png")
    var tileBH = OCImageView(filename: "RedDot.png")
    var tileCA = OCImageView(filename: "RedDot.png")
    var tileCB = OCImageView(filename: "RedDot.png")
    var tileCC = OCImageView(filename: "RedDot.png")
    var tileCD = OCImageView(filename: "RedDot.png")
    var tileCE = OCImageView(filename: "RedDot.png")
    var tileCF = OCImageView(filename: "RedDot.png")
    var tileCG = OCImageView(filename: "RedDot.png")
    var tileCH = OCImageView(filename: "RedDot.png")
    var tileDA = OCImageView(filename: "RedDot.png")
    var tileDB = OCImageView(filename: "RedDot.png")
    var tileDC = OCImageView(filename: "RedDot.png")
    var tileDD = OCImageView(filename: "RedDot.png")
    var tileDE = OCImageView(filename: "RedDot.png")
    var tileDF = OCImageView(filename: "RedDot.png")
    var tileDG = OCImageView(filename: "RedDot.png")
    var tileDH = OCImageView(filename: "RedDot.png")
    var tileEA = OCImageView(filename: "RedDot.png")
    var tileEB = OCImageView(filename: "RedDot.png")
    var tileEC = OCImageView(filename: "RedDot.png")
    var tileED = OCImageView(filename: "RedDot.png")
    var tileEE = OCImageView(filename: "RedDot.png")
    var tileEF = OCImageView(filename: "RedDot.png")
    var tileEG = OCImageView(filename: "RedDot.png")
    var tileEH = OCImageView(filename: "RedDot.png")
    var tileFA = OCImageView(filename: "RedDot.png")
    var tileFB = OCImageView(filename: "RedDot.png")
    var tileFC = OCImageView(filename: "RedDot.png")
    var tileFD = OCImageView(filename: "RedDot.png")
    var tileFE = OCImageView(filename: "RedDot.png")
    var tileFF = OCImageView(filename: "RedDot.png")
    var tileFG = OCImageView(filename: "RedDot.png")
    var tileFH = OCImageView(filename: "RedDot.png")
    var tileGA = OCImageView(filename: "RedDot.png")
    var tileGB = OCImageView(filename: "RedDot.png")
    var tileGC = OCImageView(filename: "RedDot.png")
    var tileGD = OCImageView(filename: "RedDot.png")
    var tileGE = OCImageView(filename: "RedDot.png")
    var tileGF = OCImageView(filename: "RedDot.png")
    var tileGG = OCImageView(filename: "RedDot.png")
    var tileGH = OCImageView(filename: "RedDot.png")
    var tileHA = OCImageView(filename: "RedDot.png")
    var tileHB = OCImageView(filename: "RedDot.png")
    var tileHC = OCImageView(filename: "RedDot.png")
    var tileHD = OCImageView(filename: "RedDot.png")
    var tileHE = OCImageView(filename: "RedDot.png")
    var tileHF = OCImageView(filename: "RedDot.png")
    var tileHG = OCImageView(filename: "RedDot.png")
    var tileHH = OCImageView(filename: "RedDot.png")

    

    let Red = OCImageView(filename: "RedDot.png")

    // var buttons: [[OCImageView]] = []
    // for _ in 0..<8{
    //     var buttonRow: [OCImageView] = []
    //     for _ in 0..<8{
    //         buttonRow.append(OCImageView(filename: "RedDot.png"))
    //     }
    //     buttons.append(buttonRow)
    // }

    override open func main(app: OCAppDelegate) -> OCControl {
        // Returns the fully laid out GUI.
        // var buttonRows: [OCControl] = []
        let TileButtonsRowOne = OCHBox(controls: [tileAA, tileAB, tileAC, tileAD, tileAE, tileAF, tileAG, tileAH])
        let TileButtonsRowTwo = OCHBox(controls: [tileBA, tileBB, tileBC, tileBD, tileBE, tileBF, tileBG, tileBH])
        let TileButtonsRowThree = OCHBox(controls: [tileCA, tileCB, tileCC, tileCD, tileCE, tileCF, tileCG, tileCH])
        let TileButtonsRowFour = OCHBox(controls: [tileDA, tileDB, tileDC, tileDD, tileDE, tileDF, tileDG, tileDH])
        let TileButtonsRowFive = OCHBox(controls: [tileEA, tileEB, tileEC, tileED, tileEE, tileEF, tileEG, tileEH])
        let TileButtonsRowSix = OCHBox(controls: [tileFA, tileFB, tileFC, tileFD, tileFE, tileFF, tileFG, tileFH])
        let TileButtonsRowSeven = OCHBox(controls: [tileGA, tileGB, tileGC, tileGD, tileGE, tileGF, tileGG, tileGH])
        let TileButtonsRowEight = OCHBox(controls: [tileHA, tileHB, tileHC, tileHD, tileHE, tileHF, tileHG, tileHH])
        let Grid = OCVBox(controls: [TileButtonsRowOne, TileButtonsRowTwo, TileButtonsRowThree, TileButtonsRowFour, TileButtonsRowFive, TileButtonsRowSix, TileButtonsRowSeven, TileButtonsRowEight])


        // for row in 0..<8{
        //     buttonRows.append(OCHBox(controls: buttons[row]))
        // }
        // let Grid = OCVBox(controls: buttonRows)
        return Grid
    }
}
