
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
    var testButton = OCButton(text: "Test")

    override open func main(app: OCAppDelegate) -> OCControl {
        // Returns the fully laid out GUI.
        return OCHBox(controls: [testButton])
    }
}


TestApp().start()