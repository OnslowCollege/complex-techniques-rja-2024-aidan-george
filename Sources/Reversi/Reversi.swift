
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
    var tileAA = OCImageView(filename: "RedDot.png")
    var tileAB = OCImageView(filename: String {"RedDot.png"})
    var tileAC = OCImageView(filename: String {"RedDot.png"})
    var tileAD = OCImageView(filename: String {"RedDot.png"})
    var tileAE = OCImageView(filename: String {"RedDot.png"})
    var tileAF = OCImageView(filename: String {"RedDot.png"})
    var tileAG = OCImageView(filename: String {"RedDot.png"})
    var tileAH = OCImageView(filename: String {"RedDot.png"})
    var tileBA = OCImageView(filename: String {"RedDot.png"})
    var tileBB = OCImageView(filename: String {"RedDot.png"})
    var tileBC = OCImageView(filename: String {"RedDot.png"})
    var tileBD = OCImageView(filename: String {"RedDot.png"})
    var tileBE = OCImageView(filename: String {"RedDot.png"})
    var tileBF = OCImageView(filename: String {"RedDot.png"})
    var tileBG = OCImageView(filename: String {"RedDot.png"})
    var tileBH = OCImageView(filename: String {"RedDot.png"})
    var tileCA = OCImageView(filename: String {"RedDot.png"})
    var tileCB = OCImageView(filename: String {"RedDot.png"})
    var tileCC = OCImageView(filename: String {"RedDot.png"})
    var tileCD = OCImageView(filename: String {"RedDot.png"})
    var tileCE = OCImageView(filename: String {"RedDot.png"})
    var tileCF = OCImageView(filename: String {"RedDot.png"})
    var tileCG = OCImageView(filename: String {"RedDot.png"})
    var tileCH = OCImageView(filename: String {"RedDot.png"})
    var tileDA = OCImageView(filename: String {"RedDot.png"})
    var tileDB = OCImageView(filename: String {"RedDot.png"})
    var tileDC = OCImageView(filename: String {"RedDot.png"})
    var tileDD = OCImageView(filename: String {"RedDot.png"})
    var tileDE = OCImageView(filename: String {"RedDot.png"})
    var tileDF = OCImageView(filename: String {"RedDot.png"})
    var tileDG = OCImageView(filename: String {"RedDot.png"})
    var tileDH = OCImageView(filename: String {"RedDot.png"})
    var tileEA = OCImageView(filename: String {"RedDot.png"})
    var tileEB = OCImageView(filename: String {"RedDot.png"})
    var tileEC = OCImageView(filename: String {"RedDot.png"})
    var tileED = OCImageView(filename: String {"RedDot.png"})
    var tileEE = OCImageView(filename: String {"RedDot.png"})
    var tileEF = OCImageView(filename: String {"RedDot.png"})
    var tileEG = OCImageView(filename: String {"RedDot.png"})
    var tileEH = OCImageView(filename: String {"RedDot.png"})
    var tileFA = OCImageView(filename: String {"RedDot.png"})
    var tileFB = OCImageView(filename: String {"RedDot.png"})
    var tileFC = OCImageView(filename: String {"RedDot.png"})
    var tileFD = OCImageView(filename: String {"RedDot.png"})
    var tileFE = OCImageView(filename: String {"RedDot.png"})
    var tileFF = OCImageView(filename: String {"RedDot.png"})
    var tileFG = OCImageView(filename: String {"RedDot.png"})
    var tileFH = OCImageView(filename: String {"RedDot.png"})
    var tileGA = OCImageView(filename: String {"RedDot.png"})
    var tileGB = OCImageView(filename: String {"RedDot.png"})
    var tileGC = OCImageView(filename: String {"RedDot.png"})
    var tileGD = OCImageView(filename: String {"RedDot.png"})
    var tileGE = OCImageView(filename: String {"RedDot.png"})
    var tileGF = OCImageView(filename: String {"RedDot.png"})
    var tileGG = OCImageView(filename: String {"RedDot.png"})
    var tileGH = OCImageView(filename: String {"RedDot.png"})
    var tileHA = OCImageView(filename: String {"RedDot.png"})
    var tileHB = OCImageView(filename: String {"RedDot.png"})
    var tileHC = OCImageView(filename: String {"RedDot.png"})
    var tileHD = OCImageView(filename: String {"RedDot.png"})
    var tileHE = OCImageView(filename: String {"RedDot.png"})
    var tileHF = OCImageView(filename: String {"RedDot.png"})
    var tileHG = OCImageView(filename: String {"RedDot.png"})
    var tileHH = OCImageView(filename: String {"RedDot.png"})

    

    let Red = OCImageView(filename: String {"RedDot.png"})

    // var buttons: [[OCImageView]] = []
    // for _ in 0..<8{
    //     var buttonRow: [OCImageView] = []
    //     for _ in 0..<8{
    //         buttonRow.append(OCImageView(filename: String {"RedDot.png"}))
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
