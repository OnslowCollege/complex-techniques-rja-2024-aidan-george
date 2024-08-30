
<script lang="ts">
    // import from cards.ts
    import { cards } from "./cards";
    import { aces } from "./cards";
    import type { CardInfo } from "./cards";

    // Defining possible states for the game
    type State =
        | "start"
        | "playing"
        | "playerTurn"
        | "opponentTurn"
        | "paused"
        | "won"
        | "help"
        | "lost"
        | "draw"
        | "suitSelect"
        | "pop-up"

    // Defining variables and constants 
    let state: State = 'start' // Current state of the game
    let playerCardCount = 0; // The amount of cards in the players hand
    let oppositionCardCount = 0; // The amount of cards in the oppositions hand
    let turnCount: number = 0; // The number of turns that have occured in the game
    let playerCards: CardInfo[] = []; // The cards in the players hand
    let oppositionCards: CardInfo[] = []; // The cards in the oppositions hand
    let handLength: number = 7; // The length of a hand should start at 
    let clicked: CardInfo[] = []; // The card selected by the player
    let currentCard: CardInfo[] = []; // The current card that has been played
    let dealPile: CardInfo[] = cards; // The cards in the pile that are not in play (yet to be dealt)
    let pickupAmount: number = 0; // The amount of cards that will be picked up upon a player not being able to play
    let playableCards: CardInfo[] = []; // The amount of cards in a players hand that can be played
    let lastCardActive = false; // Whether the last card button has been clicked
    let helpActive = false; // Whether the help button has been clicked
    let pileCount = dealPile.length; // The amount of cards left that are available to be dealt
    let pickupAlert = false; // Whether the player must pick up
    let popUpActive = false; // Whether the pop up is active
    const suits: string[] = ['clubs', 'diamonds', 'hearts', 'spades']; //  All the possible suits

    /* Allow the user to pause the game */
    function pauseGame(e: KeyboardEvent) {
        // Toggle between "paused" and "playerTurn" states
        if (e.key === "Escape") {
            if (state === "playerTurn") {
                state = "paused"
            } else if (state === "paused") {
                state = "playerTurn"
            }
        }
    }

    /* Toggles help screen on and off on press of buttons */
    function toggleHelpScreen() {
        if (helpActive === false) {
        helpActive = true;
        state = "help";
        }
        else {
            helpActive = false;
            state = "start"
        }
    }

    /* Toggles last card penalty pop up screen after not checking */ 
    function togglePopUp() {
        if (popUpActive === false) {
            popUpActive = true;
            state = "pop-up";
        }
        else {
            popUpActive = false;
            state = "playerTurn";
        }
    }


    /* Returns a random card from the deck */
    function getRandomCard<T>(array: T[]): T | undefined {
        // Return undefined if deck is empty
        if (array.length === 0) {
            return undefined;
        }
        // Generate random index
        const randomIndex = Math.floor(Math.random() * array.length);
        return array[randomIndex];
    }
    

    /* Deals starting deck cards */
    function dealTrial() {
        // Deal Player cards
        for (let i = 0; i < handLength; i++) {
            const randomCard: CardInfo | undefined = getRandomCard(dealPile);
            if (randomCard) {
                // Remove the card from the array
                dealPile = dealPile.filter(card => card !== randomCard);
                playerCards.push(randomCard);
            }
        }
        playerCardCount = playerCards.length

        // Deal Opposition cards
        for (let i = 0; i < handLength; i++) {
            const randomCard: CardInfo | undefined = getRandomCard(dealPile);
            if (randomCard) {
                // Remove the card from the array
                dealPile = dealPile.filter(card => card !== randomCard);
                oppositionCards.push(randomCard);
            }
        }
        // Calculate the total cards in each players hand
        oppositionCardCount = oppositionCards.length
        pileCount = dealPile.length;

    }

    /* Handles click of last card button */
    function handleLastCardClick() {
        if (playerCards.length === 2) {
            lastCardActive = true
        }
    }

    /* Logic for opponent CPU */
    function opponentTurn() {
        // Update deck counter
        pileCount = dealPile.length 

        // End the game if the deck has no cards left
        if (dealPile.length === 0) {
            gameDraw(); 
            return;
        }

        // End the game if the player has no cards left
        if (playerCards.length === 0) {
            gameWon(); 
            return;
        }

        // End the game if the opponent has no cards left
        if (oppositionCards.length === 0) {
            console.log('Opponent has no cards left');
            gameLost(); 
            return; 
        } 

        // Find cards that can be played based on the current card
        if (currentCard.name === "2" || currentCard.name === "5") {
            playableCards = oppositionCards.filter(card => 
                card.name === currentCard?.name
            );
        } else {
            playableCards = oppositionCards.filter(card => 
                card.suit === currentCard?.suit || card.name === currentCard?.name || card.name === "ace"
            );
        }

        // If no playable cards, the opponent must draw a card (if applicable)
        if (playableCards.length === 0) {
            if (pickupAmount === 0 ){
                console.log('Opponent has no playable cards, must draw a card');
                pickup(oppositionCards)
                state = 'playerTurn';
                turnCount++;
                return;
            } else {
                // Opponent must pick up multiple cards
                console.log('Opponent has no playable cards, must draw a card');
                for (let i = 0; i < pickupAmount; i++) {
                    pickup(oppositionCards)
                }
                currentCard.name = ""
                pickupAmount = 0
                state = 'playerTurn'; 
                turnCount++;
                return;
            }
        }

        // Select a random card from the playable cards
        const randomIndex = Math.floor(Math.random() * playableCards.length);
        const cardToPlay = playableCards[randomIndex];

        // Update the current card with the card played by the opponent
        currentCard = cardToPlay;

        // Remove the card from the opponent's hand
        oppositionCards = oppositionCards.filter(card => card !== cardToPlay);
        oppositionCardCount = oppositionCards.length;

        console.log('Opponent played:', cardToPlay);

        // Special card rules 
        if (cardToPlay.name === '2') {
            pickupAmount += 2
            console.log(pickupAmount)
        }
        if (cardToPlay.name === '5') {
            pickupAmount += 5
            console.log(pickupAmount)
        }
        if (cardToPlay.name === '10') {
            state = 'playing'
            state = 'opponentTurn' 
            return
        }
        if (cardToPlay.name === 'ace') {
            const randomIndex = Math.floor(Math.random() * suits.length);
            let chosenSuit = suits[randomIndex];
            const aces: CardInfo[] = cards.filter(obj => obj.name === "ace")
            const result = aces.find(obj => obj.suit === chosenSuit)
            if (result) {
                currentCard = result
            }
        }

        // Transition back to the player's turn
        state = 'playerTurn';
        turnCount++; // Add to turn counter
    }

    /* Logic for picking up automatically if the user has no usable cards */
    function autoPickup() {
        if (currentCard.name === "2" || currentCard.name === "5") {
            playableCards = playerCards.filter(card => 
                card.name === currentCard?.name
            );
        } else {
            playableCards = playerCards.filter(card => 
                card.suit === currentCard?.suit || card.name === currentCard?.name || card.name === "ace"
            );
        }

        // If no playable cards, the give a message that the player must draw a card
        if (playableCards.length === 0) {
            pickupAlert = true
        } else {
            pickupAlert = false
        }
    }

    /* Handles selecting a suit once playing an ace */
    function suitSelect(selectedSuit: any) {
        const aces: CardInfo[] = cards.filter(obj => obj.name === "ace")
        const result = aces.find(obj => obj.suit === selectedSuit)
        if (result) {
            currentCard = result
        }
    }


    function playerTurn() {
        // Update deck counter
        pileCount = dealPile.length

        // Check for win/loss conditions (e.g., if the player has no cards left)
        if (playerCards.length === 0) {
            gameWon();
            return;
        }

        // End the game if the deck is empty
        if (dealPile.length === 0) {
            gameDraw();
            return;
        }

        // End the game if the opponent has no cards left
        if (oppositionCards.length === 0) {
            console.log('Opponent has no cards left');
            gameLost(); 
            return; 
        } 

        // Check if the selected card can be played
        if (pickupAmount !== 0){
            if (currentCard.name === clicked.name) {
                currentCard = clicked;
                state = "opponentTurn";

                // Remove played card for the players cards
                playerCards = playerCards.filter(card => card !== clicked);
                playerCardCount = playerCards.length;
                
                pickupAmount += Number(clicked.name)
                console.log(pickupAmount)
            }

        } else if (clicked.name === 'ace') {
            currentCard = clicked
            state = "suitSelect"
            lastCardCheck()
            playerCards = playerCards.filter(card => card !== clicked);
            playerCardCount = playerCards.length;
            return
        } else if (
            currentCard.length === 0 ||
            currentCard?.suit === clicked?.suit ||
            currentCard?.name === clicked?.name
        ) {
            currentCard = clicked;
            console.log(clicked)

            // Special card rules

            if (clicked.name === "2" || clicked.name === "5") {
                pickupAmount += Number(clicked.name)
                console.log(pickupAmount)
            }

            playerCards = playerCards.filter(card => card !== clicked);
            playerCardCount = playerCards.length;

            if (clicked.name === '10') {
                state = 'playerTurn'
                turnCount++; // Skip opponent turn and add to the turn count
                lastCardCheck()
                return
            }
            if (clicked.name === 'ace') {
                state = "suitSelect"
                lastCardCheck()
                return
            }
            state = "opponentTurn";
            // Check status of last card button
            lastCardCheck();
        }
    }

    /* Logic for setting up player to pick up a card */
    function playerPickup() {
        // Player must pickup cards
        if (pickupAmount === 0 ){
            console.log('Player has no playable cards, must draw a card');
            pickup(playerCards)
            state = 'opponentTurn';
            return;
        } else {
            console.log('Player has no playable cards, must draw a card');
            for (let i = 0; i < pickupAmount; i++) {
                pickup(playerCards)
            }
            currentCard.name = ""
            lastCardCheck()
            pickupAmount = 0
            state = 'opponentTurn'; 
            return;
        }
    }

    /* Logic for pick up of player and opponent */
    function pickup(competitor: CardInfo[]) {

        const randomCard: CardInfo | undefined = getRandomCard(dealPile)

        if (dealPile.length === 0) {
            gameDraw();
            return;
        }

        // Disable last card button
        lastCardActive = false;

        if (randomCard) {
            // Remove the card from the array
            dealPile = dealPile.filter(card => card !== randomCard);
            competitor.push(randomCard);
            console.log("adding", randomCard)
            pileCount = dealPile.length

            if (state === 'playerTurn') {
                // Update card counter for the player
                playerCardCount = playerCards.length
                console.log(playerCards)
            }
            else {
                // Update card counter for the opponent
                oppositionCardCount = oppositionCards.length
                console.log(oppositionCards)
            }
        }
    }

    /* Adds card for the first card on the playing pile */
    function startCard() {
        const randomCard: CardInfo = getRandomCard(dealPile)

        if (randomCard.name !== "2" && randomCard.name !== "5" && randomCard.name !== "10" && randomCard.name !== "ace") {
            // Remove the card from the array
            dealPile = dealPile.filter(card => card !== randomCard);
            currentCard = randomCard
        } else {
            startCard()
            return;
        }
    }

    /* Checks if last card has been press prior to the player having one card left and applies penalty if so */
    function lastCardCheck() {
        console.log(lastCardActive)
        console.log(playerCardCount)
        if (playerCardCount === 1 && !lastCardActive) {
            togglePopUp();
            pickupAmount += 2
        }
        if (playerCardCount >= 2 && lastCardActive === true) {
            lastCardActive = false
            
        }
    }


    /* Reset game to starting condition */
    function resetGame() {
        window.location.reload();
    }

    /* When game is won give option to reset */
    function gameWon() {
        state = "won";
    }

    /* When game is lost give option to reset */
    function gameLost() {
        state = "lost";
    }

    /* When game is draw give option to reset */
    function gameDraw() {
        state = "draw";
    }

    /* Checking if the state is "playerTurn" and running autopickup function if so */
    $: if (state === 'playerTurn') {
        console.log(state)
        setTimeout(() => {
            autoPickup();
        }, 2)
    }

    /* Checking if the state is "opponentTurn" and setting a timeout */
    $: if (state === 'opponentTurn') {
        setTimeout(() => {
            opponentTurn();
        }, 2000)
    }

    $: {lastCardCheck()}

</script>

<svelte:window on:keydown={pauseGame} />

<!--Checks if game is paused and adds header text--> 
{#if state === "paused"}
    <h1>Game paused</h1>
{/if}

<!--Checks if the game's state is start and creates the classes and buttons for the start screen-->
{#if state === "start"}
    <div class="start-area">
    <h1>Last Card</h1>
    <div class="start-area-buttons">
    <button on:click = {() => {
        (state = 'playerTurn');
        turnCount++;
        dealTrial();
        startCard();
        }}
        class="start-button">
        Start
    </button>
    <button on:click={toggleHelpScreen} class="help-button"> <!--Goes to help screen by toggling function-->
        Help
    </button>
    </div>
    </div>
    {/if}

<!--Checks if the game's state is help and if so show help text and button to return-->
    {#if state === "help"}
    <div class="help-screen">
    <h1>Rules of Last Card</h1>
    <p>
        The game starts with 7 cards in each deck, one deck for the player and one for the CPU opponent. 
        
        Players must play either the same suit, or the same number as the previous card played.

        If a player cannot play a card they pick a card from the draw pile. Their turn is now over.
        
        Ace is used as a wild card and can be used on top of any other card. When a player plays an ace, they can use it to change the suit of the cards being played.
        
        When a player has one remaining card in their hand they must say “Last Card.” They must do this before they play their 2nd to last card. If they do not, and they play their card on their next turn, they must pick up another 2 cards.
        
        The first person to get rid of their hand is the winner.
        
        If a player plays a 2, the next player must pick up 2 cards. Alternatively, they could play another 2 and the next player would have to pick up 4.

        It also applies if a player plays a 5. The next player picks up 5 cards, or adds another 5 to accumulate.

        If a player plays a 10, the next players turn is skipped.

        If the deck empties and the game is therefore impossible to win, the game will be declared a draw.
    </p>
        <button on:click={toggleHelpScreen} class="return-button"> <!--Returns to start screen by toggling function-->
        Return
        </button>
        </div>
{/if}

<!--If state is "pop-up" then show text to inform user of penalty-->
{#if state === "pop-up"}
    <div class="last-card-pop-up">
        <h2>You did not press the last card button when you had 2 cards left and played one!</h2>
        <p>Picking up 2 cards as a penalty.</p>
        <button on:click={togglePopUp} class="return-button"> <!--Returns to playerTurn state as before-->
        ok
        </button>
    </div>
{/if}

<!--If state is "playerTurn" then add the interface and make the cards clickable-->
{#if state === "playerTurn"}
    <div class="cards">
        {#each oppositionCards as oppositionHandCard}
        <button class="card">
        <img src="/cards/backcard.png" alt="Back of card" /> <!--Shows back of card image for the opponents cards-->
        </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter">{oppositionCardCount}</div> <!-- Shows number of opponent cards-->
    </div>
    <div>
        <h1 >player turn</h1>
        <h1>
            turn: {turnCount} <!--Shows number of turns that have been played-->
        </h1>
    </div>
    <div class="center">
        <div class="pickup-area">
        {#if pickupAlert}
        <div class="pickup-alert">
            <p>Player must pickup</p> <!-- Alert if user has to pick up-->
        </div>
        {/if}
        <div class="pile-count">
            <div class="pile-counter">{pileCount}</div> <!--Shows number of cards in the deck-->
        </div>
        <button on:click = {() => {
            playerPickup();
            state = "opponentTurn";
        }} class="card pickup-pile">
            <img src="/cards/backcard.png" alt="Pickup Card Pile" />
        </button>
        <button class="card">
            <img src={currentCard?.image} alt={currentCard?.name} loading="lazy"/> <!-- Loads card images for player and only loads the ones that are needed-->
        </button>
    </div>
    </div>
    <div class="cards">
        {#each playerCards as playerHandCard} <!-- Adds clicked card to the clicked card variable and assigns it to the playing pile-->
            <button
                on:click={() => (clicked = playerHandCard)} 
                on:click={playerTurn}
                class="card"
            >
                <img
                    src={playerHandCard.image}
                    alt={playerHandCard.name}
                    loading="lazy"
                />
            </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter player-card-counter">{playerCardCount}</div> <!-- Shows number of cards for the player-->
    </div> <!-- Handles last card button press and checks if the button has been clicked or not to make responsive changes in the UI-->
    <button 
    on:click={handleLastCardClick}
    class="last-card-button {lastCardActive ? 'clicked' : ''}"
    disabled={playerCards.length !== 2} 
    >
        Last Card
    <span class="tooltip">Click when you have 2 cards left and are about to place your 2nd to last card.</span> <!-- Information about the last card button on hover-->
    </button>
{/if}

<!--If state is "opponentTurn" then make the player's cards unclickable-->
{#if state === 'opponentTurn'} 
    
    <div class="cards">
        {#each oppositionCards as oppositionHandCard}
        <button class="card">
        <img src="/cards/backcard.png" alt="Back of card" />
        </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter">{oppositionCardCount}</div>
    </div>
    <div>
        <h1>opposition turn</h1>
        <h1>
            turn: {turnCount}
        </h1>
    </div>
    <div class="center">
        <div class="pickup-area">
        {#if pickupAlert}
        <div class="pickup-alert">
            <p>Player must pickup</p>
        </div>
        {/if}
        <div class="pile-count">
            <div class="pile-counter">{pileCount}</div>
        </div>
        <button class="card pickup-pile">
            <img src="/cards/backcard.png" alt="Pickup Card Pile" />
        </button>
        <button class="card">
            <img src={currentCard?.image} alt={currentCard?.name} loading="lazy"/>
        </button>
        </div>
        </div>
    <div class="cards">
        {#each playerCards as playerHandCard}
            <button class="card">
                <img
                    src={playerHandCard.image}
                    alt={playerHandCard.name}
                    loading="lazy"
                />
            </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter player-card-counter">{playerCardCount}</div>
    </div>
    <button 
    on:click={handleLastCardClick}
    class="last-card-button"
    disabled 
    >
        Last Card
    </button>
{/if}

<!-- If state is "playing" shows standard base state where it is neither player's turn-->
{#if state === "playing"}
    <div class="cards">
        {#each oppositionCards as oppositionHandCard}
            <button
                on:click={() => (clicked = oppositionHandCard)}
                class="card"
            >
                <img src="/cards/backcard.png" alt="Back of card" />
            </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter">{oppositionCardCount}</div>
    </div>
    <div class="center">
        <div class="pickup-area">
        {#if pickupAlert}
        <div class="pickup-alert">
            <p>Player must pickup</p>
        </div>
        {/if}
        <div class="pile-count">
            <div class="pile-counter">{pileCount}</div>
        </div>
        <button class="card pickup-pile">
            <img src="/cards/backcard.png" alt="Pickup Card Pile" />
        </button>
        <button class="card">
            <img src={currentCard?.image} alt={currentCard?.name} />
        </button>
    </div>
    </div>
    <div class="cards">     
        {#each playerCards as playerHandCard}
            <button on:click={() => (clicked = playerHandCard)} class="card">
                <img src={playerHandCard.image} alt={playerHandCard.name} loading="lazy"/>
            </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter player-card-counter"> {playerCardCount} </div>
        
    </div>
{/if}

<!--If state is "suitSelect" add suit select interface to let user select their suit-->
{#if state === "suitSelect"}
    <div class="cards">
        {#each oppositionCards as oppositionHandCard}
            <button class="card">
                <img src="/cards/backcard.png" alt="Back of card" />
            </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter">{oppositionCardCount}</div>
    </div>
    <div class="suit-select-box">     
        {#each aces as ace}
            <button 
            on:click={() => (suitSelect(ace.suit))}
            on:click={() => (state = "opponentTurn")}
            class="suit-select">
                <img src={ace.image} alt={ace.name} loading="lazy"/>
            </button>
        {/each}
    </div>
    <div class="cards">     
        {#each playerCards as playerHandCard}
            <button class="card">
                <img src={playerHandCard.image} alt={playerHandCard.name} loading="lazy"/>
            </button>
        {/each}
    </div>
    <div class="card-count">
    <div class="card-counter player-card-counter">{playerCardCount}</div>
    </div>
{/if}

<!-- If state is "won" show screen that says player has won-->
{#if state === "won"}
    <div class ="win-screen">
        <h1>You Won!</h1>
        <h2>Press the retry button to play again</h2>
        <button on:click={resetGame} class="retry-button"> <!-- Reset game function called on press to reload game-->
            retry
            </button>
    </div>
{/if}

<!-- If state is "lost" show screen that says player has lost-->
{#if state === "lost"}
    <div class ="loss-screen">
        <h1>You Lost!</h1>
        <h2>Press the retry button to play again</h2>
        <button on:click={resetGame} class="retry-button">
            retry
            </button>
    </div>
{/if}

<!-- If state is "draw" show screen that says player has drawn-->
{#if state === "draw"}
    <div class ="draw-screen">
        <h1>You Drew!</h1>
        <h2>Press the retry button to play again</h2>
        <button on:click={resetGame} class="retry-button">
            retry
            </button>
    </div>
{/if}

<style>
    .suit-select-box {
    display: flex;
    justify-content: center; /* Horizontally centers the items */
    align-items: center; /* Vertically centers the items, if container has a height */
    flex-wrap: wrap; /* Allows wrapping of items if they exceed container width */
    gap: 2rem;
    }

    .center {
        margin: auto;
        background-color: hsl(122, 92%, 20%);
    }
    .cards {
        display: flex;
        grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
        gap: 8px;
    }

    @keyframes flash { /* Animation for when last card button is active to make it more visible */
        0% {background-color: white;}
        50% {background-color: red;}
        100% {background-color: white;}
    }

    .start-area {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
    }

    .start-area-buttons {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1rem;
    }
    .start-button, .help-button { /* Centers and styles the buttons on the main menu */
        position: relative;
        padding: 2rem 2.5rem;
        font-size: 1.5rem;
        border: none;
        border-radius: 4px;
        background-color: white;
        color: black;
        cursor: pointer;
        transition: background-color 0.3s ease;
        text-align: center;
        display: inline-block;
    }

    .start-button:hover { /* Makes start button golden on hover */
        background-color: gold;
    }


    .help-button:hover { /* Makes help button red on hover */
        background-color: red;
    }

    .help-screen, .last-card-pop-up { /* Style for the pop-up and help screens */
        position: fixed;
        top: 0;
        right: 0;
        width: 100%;
        height: 100%;
        background-color: hsl(122, 92%, 20%);
        color: white;
        padding: 2rem;
        box-sizing: border-box;
        overflow-y: auto;
        z-index: 1000;
    }

    .help-screen p {
        font-size: 1.5rem;
    }


    .return-button, .retry-button { 
        position: fixed;
        bottom: 1rem;
        right: 1rem;    
        padding: 1.5rem 2rem;
        font-size: 1.2rem;
        border: none;
        border-radius: 4px;
        background-color: white;
        color: black;
        cursor: pointer;
        transition: background-color 0.3s ease;
        text-align: center;
        display: inline-block;
    }

    .return-button:hover {
        background-color: red;
    }

    .card {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 1rem;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        background: none;
        max-width: 90%;
        max-height: 90%;
    }
    .card img { /* Style for how the images of the cards display in the game */
        display: block;
        max-width: 100%;
        max-height: 100%;   
        object-fit: scale-down;
    }

    .last-card-button {
        position: fixed;
        bottom: 1rem;
        right: 1rem;    
        padding: 1.5rem 2rem;
        font-size: 1.2rem;
        border: none;
        border-radius: 4px;
        background-color: white;
        color: black;
        cursor: pointer;
        transition: background-color 0.3s ease;
        text-align: center;
        display: inline-block;
    }

    .last-card-button .tooltip { /* Show information on the button and make it visible when hovered*/
        visibility: hidden;
        background-color: grey;
        color: white;
        text-align: center;
        border-radius: 5px;
        padding: 5px;
        position: absolute;
        z-index: 1;
        bottom: 125%;
        right: 50%;
        margin-left: -60px;
        opacity: 0;
        transition: opacity 0.3s;
    }

    .last-card-button:hover .tooltip { /* Make the last card button change colour when the user hovers over */
        visibility: visible;
        opacity: 1;
    }

    .last-card-button:disabled { /* How the last card button appears when disabled */
        background-color: grey;
        cursor: not-allowed;
    }

    .last-card-button:not(:disabled) { /* When button is enable play animation */
    animation: flash 1s infinite;
    }


    .last-card-button:not(:disabled):hover {
        background-color: red;
    }

    .last-card-button.clicked {
        background-color: gold;
        animation: none;
    }


    .card-count {
        display: flex;
        gap: 10px; /* Optional: Adds space between items */
        flex-direction: column;
        align-items: left;
        margin: 0;
    }

    .pickup-alert {
        font-size: 1.2rem;
        padding: 0.5rem;
        background-color: rgb(248, 12, 12);
        color: rgb(252, 251, 251);
        border: 2px black;
        border-radius: 0.5rem;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        text-align: center;
        width: 100px;
        margin-bottom: 1rem;
    }

    .pickup-area {
        display: flex;
        align-items: center;
    }

    .pile-count {
        display: flex;
        align-items: center;
        margin-right: 10px;
    }

    .card-counter, .pile-counter {
        font-size: 1.2rem;
        padding: 0.5rem;
        background-color: white;
        color: black;
        border: 2px black;
        border-radius: 0.5rem;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        text-align: center;
        width: 100px;
        margin-bottom: 1rem;
    }

        .player-card-counter {
            margin-top: 1rem;
        }
    

    .win-screen, .loss-screen, .draw-screen {
        position: fixed;
        top: 0;
        right: 0;
        width: 100%;
        height: 100%;
        background-color: hsl(122, 92%, 20%);
        color: white;
        padding: 2rem;
        box-sizing: border-box;
        overflow-y: auto;
        z-index: 1000;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
    }

    .win-screen, .loss-screen, .draw-screen h2 {
        margin-top: 1rem;
    }


</style>
