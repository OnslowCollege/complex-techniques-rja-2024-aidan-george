// // The Swift Programming Language
// // https://docs.swift.org/swift-book

// import Adwaita

// @main
// struct Reversi: App {

//     let id = "nz.school.OnslowCollege.Reversi"
//     var app: GTUIApp!

//     var scene: Scene {
//         Window(id: "main") { window in
//             Text("NotReversi")
//                 .padding()
//                 .topToolbar {
//                     ToolbarView(app: app, window: window)
//                 }
//         }
//         .defaultSize(width: 450, height: 300)
//     }

// }

//
//  main.swift
//  OCProgram
//
//  Created by Kellan Van Koughnet on 15/05/24.
//

import Foundation
import OCGUI

struct FlashCard {
    let reoMaori: String
    let english: String
}

// The FlashCard objects that hold the text for both English and Reo Māori.
// NOTE: No macrons on Reo Māori as the user typing their answer may not know how to add them to their typing.
let card0 = FlashCard(reoMaori: "Kia ora", english: "Hi")
let card1 = FlashCard(reoMaori: "Tena koe", english: "Hello (to 1)")
let card2 = FlashCard(reoMaori: "Tena korua", english: "Hello (to 2)")
let card3 = FlashCard(reoMaori: "Tena koutou", english: "Hello (to 3+)")
let card4 = FlashCard(reoMaori: "Kei te pehea koe?", english: "How are you?")
let card5 = FlashCard(reoMaori: "Kei te pai", english: "I'm fine")
let card6 = FlashCard(reoMaori: "Tino pai to mahi!", english: "Excellent work!")
let card7 = FlashCard(reoMaori: "Ka mau te wehi!", english: "Awesome!")
let card8 = FlashCard(reoMaori: "Titiro mai", english: "Listen to me")
let card9 = FlashCard(reoMaori: "Whakarongo mai", english: "Look at me")
let card10 = FlashCard(reoMaori: "Ae", english: "Yes")
let card11 = FlashCard(reoMaori: "Kahore", english: "No")
let card12 = FlashCard(reoMaori: "Tika", english: "Correct")
let card13 = FlashCard(reoMaori: "Mahunga", english: "Head")
let card14 = FlashCard(reoMaori: "Ringa", english: "Hands")
let card15 = FlashCard(reoMaori: "Waewae", english: "Legs")

/// Constant that holds the values of how many cards can be played.
let numberOfCardsArray: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]

class FlashCardApp : OCApp {
    // Drop-down for selecting how many cards the user wants to play.
    let numCardsChoice: OCDropDown = OCDropDown(fromArray: numberOfCardsArray)

    // The label for indicating the control that's used to choose the number of flash cards to play.
    let numCardsLabel: OCLabel = OCLabel(text: "Choose number of cards:")

    // Variable for the number of cards the user has selected for use in playing the correct number of cards.
    var numCardsShow: Int = 1

    // Constant for the label that indicates where the FlashCard text is being shown.
    let cardLabel: OCLabel = OCLabel(text: "Flash Card Text:")

    // The label that is used to display a card's string.
    var cardDisplay: OCLabel = OCLabel(text: "")

    // An array of flashcard objects.
    var flashCards: [FlashCard] = [card0, card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13, card14, card15]

    // The textfield for the user to input their answer.
    var answerTextField: OCTextField = OCTextField(hint: "Enter your answer.")

    // Button for when the user has clicked an answer and is ready to commit.
    var startNextButton: OCButton = OCButton(text: "Start/Next.")

    // Constant for when the text of the flipCardButton is showing the chosen side to be English.
    let flipCardTextEnglish: String = "English"

    // Constant for when the text of the flipCardButton is showing the chosen side to be Reo Māori.
    let flipCardTextMaori: String = "Reo Maori"

    // Constant label for indicating the button that changes the language of the card shown.
    let flipCardLabel: OCLabel = OCLabel(text: "Change Card Language:")

    // Button for changing which side of the cards are shown.
    var flipCardButton: OCButton = OCButton(text: "")

    // Variable for use in program to know what language to show.
    var chosenLanguage: String = "English"

    // Variable to count how many cards have been shown.
    var countCardsShown: Int = 0

    // Label to show which cards the user answered correctly and total score.
    var summaryLabel: OCLabel = OCLabel(text: "")

    // List that holds the data for correct and incorrect user answers.
    var summaryList: [[String]] = []

    // Variable that holds the randomly selected flash card.
    var randomlySelectedCard: FlashCard = card0

    // Variable that holds the answer to the previously shown card.
    var previousCardAnswer: String = ""

    // Variable array that holds the current answer conclusion, for appending into the summary list.
    var userAnswerConclusion: [String] = []

    /// Event function for when the "next" button is pressed.
    func startNextButtonPressed(button: OCControlClickable) {
        // If a flash card has not been shown previous to this, will assume the user is starting the flashcard app.
        if cardDisplay.text == "" {
            // Casting the correct number of cards to display to an integer.
            if let numCardsString = numCardsChoice.selectedItem?.text {
                let numCardsInt = Int(numCardsString)
                numCardsShow = numCardsInt!
                
                // Disables the change language and number of cards picker so that they can not be changed while program is running.
                flipCardButton.enabled = false
                numCardsChoice.enabled = false
                
                // Enables the text field so that the user can put in their answer.
                answerTextField.enabled = true
            }
        }

        // If this is the first card being shown, show random card and increase the counter.
        if countCardsShown == 0 {
            // Clears the summary array and label.
            summaryList = []
            summaryLabel.text = ""

            // If this variable can be changed to the random flash card, unpack optional and display correct text.
            if let randomCardOptional = flashCards.randomElement() {
                randomlySelectedCard = randomCardOptional

                // If the language chosen is English, change the card display to the Reo Māori text of the card.
                if chosenLanguage == flipCardTextEnglish {
                    cardDisplay.text = randomlySelectedCard.english
                    previousCardAnswer = randomlySelectedCard.reoMaori
                }

                // If the language chosen is Reo Māori, change the card display to show the English text of the card.
                if chosenLanguage == flipCardTextMaori {
                    cardDisplay.text = randomlySelectedCard.reoMaori
                    previousCardAnswer = randomlySelectedCard.english
                }

                // Raise counter.
                countCardsShown = countCardsShown + 1
            }
        }

        // Otherwise, if all cards have been shown, check and store result from last answer, display the summary.
        else if countCardsShown == numCardsShow {
            // If the answer was correct, store in the array as correct.
            if answerTextField.text == previousCardAnswer {
                userAnswerConclusion = [String(countCardsShown), "Correct"]
                summaryList.append(userAnswerConclusion)
            }

            // Otherwise if the answer was incorrect, store in the array as incorrect.
            else if answerTextField.text != previousCardAnswer {
                userAnswerConclusion = [String(countCardsShown), "Incorrect"]
                summaryList.append(userAnswerConclusion)
            }

            // Clear the card display and textfield.
            cardDisplay.text = ""
            answerTextField.text = ""

            // Clear the counter.
            countCardsShown = 0

            // Reenable the change language and card number selector.
            flipCardButton.enabled = true
            numCardsChoice.enabled = true

            // Disable the textfield.
            answerTextField.enabled = false

            // Display the summaries in the array to the GUI.
            for summary in summaryList {
                summaryLabel.text += "|Question \(summary[0]): \(summary[1]) "
            }
        }

        // Otherwise, if this isn't the first card being shown, compare and store result of last answer, get new card shown.
        else if countCardsShown > 0 {
            // If the answer was correct, store in the array as correct.
            if answerTextField.text == previousCardAnswer {
                userAnswerConclusion = [String(countCardsShown), "Correct"]
                summaryList.append(userAnswerConclusion)
            }

            // Otherwise if the answer was incorrect, store in the array as incorrect.
            else if answerTextField.text != previousCardAnswer {
                userAnswerConclusion = [String(countCardsShown), "Incorrect"]
                summaryList.append(userAnswerConclusion)
            }

            // Clear the textfield.
            answerTextField.text = ""

            // If this variable can be changed to the random flash card, unpack optional and display correct text.
            if let randomCardOptional = flashCards.randomElement() {
                randomlySelectedCard = randomCardOptional

                // If the language chosen is English, change the card display to the Reo Māori text of the card.
                if chosenLanguage == flipCardTextEnglish {
                    cardDisplay.text = randomlySelectedCard.english
                    previousCardAnswer = randomlySelectedCard.reoMaori
                }

                // If the language chosen is Reo Māori, change the card display to show the English text of the card.
                if chosenLanguage == flipCardTextMaori {
                    cardDisplay.text = randomlySelectedCard.reoMaori
                    previousCardAnswer = randomlySelectedCard.english
                }

                // Raise counter.
                countCardsShown = countCardsShown + 1
            }
        }
    }


    /// Event function for when "flipCardButton" button is pressed.
    func flipCardButtonPressed(button: OCControlClickable) {
        // Set the current language as the language selected.
        let currentLanguage = chosenLanguage

        // If the current language is English, set the chosen language and language button text to Reo Māori. 
        if currentLanguage == flipCardTextEnglish {
            chosenLanguage = flipCardTextMaori
            flipCardButton.text = flipCardTextMaori
        }

        // If the current language is Reo Māori, set the chosen language and language button text to English.
        if currentLanguage == flipCardTextMaori {
            chosenLanguage = flipCardTextEnglish
            flipCardButton.text = flipCardTextEnglish
        }
    }

    override open func main(app: OCAppDelegate) -> OCControl {
        // Disable the textfield.
        self.answerTextField.enabled = false

        // Change the language button text to the chosen language.
        self.flipCardButton.text = chosenLanguage

        // Event for when the start/next button is pressed.
        self.startNextButton.onClick(self.startNextButtonPressed)

        // Event for when the flip card button is pressed.
        self.flipCardButton.onClick(self.flipCardButtonPressed)

        // Formatting the controls into their respective sections of the GUI.
        let cardDisplaySection: OCHBox = OCHBox(controls: [cardLabel, cardDisplay])
        let answerSection: OCVBox = OCVBox(controls: [answerTextField, summaryLabel])
        let numCardsPortion: OCHBox = OCHBox(controls: [numCardsLabel, numCardsChoice])
        let flipCardPortion: OCHBox = OCHBox(controls: [flipCardLabel, flipCardButton])
        let optionsSection: OCVBox = OCVBox(controls: [numCardsPortion, flipCardPortion, startNextButton])
        
        return OCVBox(controls: [cardDisplaySection, answerSection, optionsSection])
    }
}

FlashCardApp().start()