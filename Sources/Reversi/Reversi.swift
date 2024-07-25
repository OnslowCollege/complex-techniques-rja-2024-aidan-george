
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
    var tileAB = OCImageView(filename: "images/RedDot.png")
    var tileAC = OCImageView(filename: "images/RedDot.png")
    var tileAD = OCImageView(filename: "images/RedDot.png")
    var tileAE = OCImageView(filename: "images/RedDot.png")
    var tileAF = OCImageView(filename: "images/RedDot.png")
    var tileAG = OCImageView(filename: "images/RedDot.png")
    var tileAH = OCImageView(filename: "images/RedDot.png")
    var tileBA = OCImageView(filename: "images/RedDot.png")
    var tileBB = OCImageView(filename: "images/RedDot.png")
    var tileBC = OCImageView(filename: "images/RedDot.png")
    var tileBD = OCImageView(filename: "images/RedDot.png")
    var tileBE = OCImageView(filename: "images/RedDot.png")
    var tileBF = OCImageView(filename: "images/RedDot.png")
    var tileBG = OCImageView(filename: "images/RedDot.png")
    var tileBH = OCImageView(filename: "images/RedDot.png")
    var tileCA = OCImageView(filename: "images/RedDot.png")
    var tileCB = OCImageView(filename: "images/RedDot.png")
    var tileCC = OCImageView(filename: "images/RedDot.png")
    var tileCD = OCImageView(filename: "images/RedDot.png")
    var tileCE = OCImageView(filename: "images/RedDot.png")
    var tileCF = OCImageView(filename: "images/RedDot.png")
    var tileCG = OCImageView(filename: "images/RedDot.png")
    var tileCH = OCImageView(filename: "images/RedDot.png")
    var tileDA = OCImageView(filename: "images/RedDot.png")
    var tileDB = OCImageView(filename: "images/RedDot.png")
    var tileDC = OCImageView(filename: "images/RedDot.png")
    var tileDD = OCImageView(filename: "images/RedDot.png")
    var tileDE = OCImageView(filename: "images/RedDot.png")
    var tileDF = OCImageView(filename: "images/RedDot.png")
    var tileDG = OCImageView(filename: "images/RedDot.png")
    var tileDH = OCImageView(filename: "images/RedDot.png")
    var tileEA = OCImageView(filename: "images/RedDot.png")
    var tileEB = OCImageView(filename: "images/RedDot.png")
    var tileEC = OCImageView(filename: "images/RedDot.png")
    var tileED = OCImageView(filename: "images/RedDot.png")
    var tileEE = OCImageView(filename: "images/RedDot.png")
    var tileEF = OCImageView(filename: "images/RedDot.png")
    var tileEG = OCImageView(filename: "images/RedDot.png")
    var tileEH = OCImageView(filename: "images/RedDot.png")
    var tileFA = OCImageView(filename: "images/RedDot.png")
    var tileFB = OCImageView(filename: "images/RedDot.png")
    var tileFC = OCImageView(filename: "images/RedDot.png")
    var tileFD = OCImageView(filename: "images/RedDot.png")
    var tileFE = OCImageView(filename: "images/RedDot.png")
    var tileFF = OCImageView(filename: "images/RedDot.png")
    var tileFG = OCImageView(filename: "images/RedDot.png")
    var tileFH = OCImageView(filename: "images/RedDot.png")
    var tileGA = OCImageView(filename: "images/RedDot.png")
    var tileGB = OCImageView(filename: "images/RedDot.png")
    var tileGC = OCImageView(filename: "images/RedDot.png")
    var tileGD = OCImageView(filename: "images/RedDot.png")
    var tileGE = OCImageView(filename: "images/RedDot.png")
    var tileGF = OCImageView(filename: "images/RedDot.png")
    var tileGG = OCImageView(filename: "images/RedDot.png")
    var tileGH = OCImageView(filename: "images/RedDot.png")
    var tileHA = OCImageView(filename: "images/RedDot.png")
    var tileHB = OCImageView(filename: "images/RedDot.png")
    var tileHC = OCImageView(filename: "images/RedDot.png")
    var tileHD = OCImageView(filename: "images/RedDot.png")
    var tileHE = OCImageView(filename: "images/RedDot.png")
    var tileHF = OCImageView(filename: "images/RedDot.png")
    var tileHG = OCImageView(filename: "images/RedDot.png")
    var tileHH = OCImageView(filename: "images/RedDot.png")

    

    let Red = OCImageView(filename: "images/RedDot.png")

    // var buttons: [[OCImageView]] = []
    // for _ in 0..<8{
    //     var buttonRow: [OCImageView] = []
    //     for _ in 0..<8{
    //         buttonRow.append(OCImageView(filename: "images/RedDot.png"))
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
