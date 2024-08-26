
<script lang="ts">
    import Layout from "./+layout.svelte";
    import { cards } from "./cards";
    import type { CardInfo } from "./cards";

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

    let state: State = 'start'
    let playerCardCount = 0;
    let turnCount: number = 0;
    let oppositionCardCount = 0;
    let playerHandCards: number[] = [];
    let playerCards: CardInfo[] = [];
    let oppositionCards: CardInfo[] = [];
    let handLength: number = 7;
    let clicked: CardInfo[] = [];
    let currentCard: CardInfo[] = [];
    let dealPile: CardInfo[] = cards;
    let pickupAmount: number = 0;
    let playableCards: CardInfo[] = [];
    let lastCardActive = false;
    let helpActive = false;
    let pileCount = dealPile.length;
    const suits: string[] = ['clubs', 'diamonds', 'hearts', 'spades'];

    /* Allow the user to pause the game */
    function pauseGame(e: KeyboardEvent) {
        if (e.key === "Escape") {
            switch (state) {
                case "playing":
                    state = "paused";
                    break;
                case "paused":
                    state = "playing";
                    break;
            }
        }
    }

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



    function getRandomCard<T>(array: T[]): T | undefined {
        if (array.length === 0) {
            return undefined;
        }
        const randomIndex = Math.floor(Math.random() * array.length);
        return array[randomIndex];
    }
    

    function dealTrial() {
        // Player cards
        for (let i = 0; i < handLength; i++) {
            const randomCard: CardInfo | undefined = getRandomCard(dealPile);
            if (randomCard) {
                // Remove the card from the array
                dealPile = dealPile.filter(card => card !== randomCard);
                playerCards.push(randomCard);
            }
        }
        playerCardCount = playerCards.length

        // Opposition cards
        for (let i = 0; i < handLength; i++) {
            const randomCard: CardInfo | undefined = getRandomCard(dealPile);
            if (randomCard) {
                // Remove the card from the array
                dealPile = dealPile.filter(card => card !== randomCard);
                oppositionCards.push(randomCard);
            }
        }
        oppositionCardCount = oppositionCards.length
        pileCount = dealPile.length;

    }


    function handleLastCardClick() {
        if (playerCards.length = 2) {
            lastCardActive = true
        }
    }

    function opponentTurn() {

        pileCount = dealPile.length

        if (dealPile.length === 0) {
            gameDraw();
            return;
        }

        // Check if the opponent has any cards left
        if (oppositionCards.length === 0) {
            console.log('Opponent has no cards left');
            gameLost(); // End the game if the opponent has no cards left
            return; 
        } 

        // Find cards that can be played based on the current card
        if (currentCard.name === "2" || currentCard.name === "5") {
            playableCards = oppositionCards.filter(card => 
                card.name === currentCard?.name
            );
        } else {
            playableCards = oppositionCards.filter(card => 
                card.suit === currentCard?.suit || card.name === currentCard?.name
            );
        }

        console.log(pickupAmount)

        // If no playable cards, the opponent must draw a card (if applicable)
        if (playableCards.length === 0) {
            if (pickupAmount === 0 ){
                console.log('Opponent has no playable cards, must draw a card');
                pickup(oppositionCards)
                // For simplicity, we'll skip drawing a card in this example
                state = 'playerTurn'; // End the opponent's turn if they have no playable cards
                turnCount++;
                return;
            } else {
                console.log('Opponent has no playable cards, must draw a card');
                for (let i = 0; i < pickupAmount; i++) {
                    pickup(oppositionCards)
                }
                currentCard.name = ""
                pickupAmount = 0
                // For simplicity, we'll skip drawing a card in this example
                state = 'playerTurn'; // End the opponent's turn if they have no playable cards
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

        // Check for win/loss conditions (e.g., if the player has no cards left)
        if (playerCards.length === 0) {
            gameWon(); // End the game if the player has no cards left
            return;
        }

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
            currentCard.suit = chosenSuit
        }

        // Transition back to the player's turn
        state = 'playerTurn';
        turnCount++;
    }

    function pickupCheck() {
        if (currentCard.name === "2" || currentCard.name === "5"){
            if (playerCards.some(card => card.name === currentCard.name)) {
                console.log("card available")
            }
            else {
                console.log("no card available")
                for (let i = 0; i < pickupAmount; i++) {
                    pickup(playerCards)
                }
                currentCard.name = ""
                pickupAmount = 0
                state = "opponentTurn"
                return
            }
        }
    }

    function autoPickup() {
        if (currentCard.name === "2" || currentCard.name === "5") {
            playableCards = playerCards.filter(card => 
                card.name === currentCard?.name
            );
        } else {
            playableCards = playerCards.filter(card => 
                card.suit === currentCard?.suit || card.name === currentCard?.name
            );
        }

        // If no playable cards, the player must draw a card (if applicable)
        if (playableCards.length === 0) {
            if (pickupAmount === 0 ){
                console.log('Player has no playable cards, must draw a card');
                pickup(playerCards)
                // For simplicity, we'll skip drawing a card in this example
                state = 'opponentTurn'; // End the player's turn if they have no playable cards
                return;
            } else {
                console.log('Player has no playable cards, must draw a card');
                for (let i = 0; i < pickupAmount; i++) {
                    pickup(playerCards)
                }
                currentCard.name = ""
                pickupAmount = 0
                // For simplicity, we'll skip drawing a card in this example
                state = 'opponentTurn'; // End the player's turn if they have no playable cards
                return;
            }
        }
    }


    function playerTurn() {

        pileCount = dealPile.length

        if (dealPile.length === 0) {
            gameDraw()
            return;
        }
    
        if (pickupAmount !== 0){
            if (currentCard.name === clicked.name) {
                currentCard = clicked;
                state = "opponentTurn";

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

            if (clicked.name === "2" || clicked.name === "5") {
                pickupAmount += Number(clicked.name)
                console.log(pickupAmount)
            }

            playerCards = playerCards.filter(card => card !== clicked);
            playerCardCount = playerCards.length;

            if (clicked.name === '10') {
                state = 'playerTurn'
                turnCount++;
                lastCardCheck()
                return
            }
            if (clicked.name === 'ace') {
                state = "suitSelect"
                lastCardCheck()
                return
            }
            state = "opponentTurn";
            lastCardCheck();
        }
    }


    function pickup(competitor: CardInfo[]) {

        const randomCard: CardInfo | undefined = getRandomCard(dealPile)

        if (dealPile.length === 0) {
            gameDraw();
            return;
        }

        if (randomCard) {
            // Remove the card from the array
            dealPile = dealPile.filter(card => card !== randomCard);
            competitor.push(randomCard);
            console.log("adding", randomCard)
            pileCount = dealPile.length

            if (state === 'playerTurn') {
                playerCardCount = playerCards.length
                console.log(playerCards)
            }
            else {
                oppositionCardCount = oppositionCards.length
                console.log(oppositionCards)
            }
        }
    }

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

    function lastCardCheck() {
        if (playerCardCount === 1 && !lastCardActive) {
            pickupAmount += 2
        }
        if (playerCardCount >= 2 && lastCardActive === true) {
            lastCardActive = false
        }
    }


    /* Reset game to starting condition */
    function resetGame() {
        state = "start";
    }

    /* When game is won give option to reset */
    function gameWon() {
        state = "won";
    }

    /* When game is lost give option to reset */
    function gameLost() {
        state = "lost";
    }

    function gameDraw() {
        state = "draw";
    }

    $: if (state === 'playerTurn') {
        console.log(state)
        setTimeout(() => {
            autoPickup();
        }, 2)
    }

    $: if (state === 'opponentTurn') {
        setTimeout(() => {
            opponentTurn();
        }, 2000)
    }



</script>

<svelte:window on:keydown={pauseGame} />

{#if state === "paused"}
    <h1>Game paused</h1>
{/if}

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
    <button on:click={toggleHelpScreen} class="help-button">
        Help
    </button>
    </div>
    </div>
    {/if}


    {#if state === "help"}
    <div class="help-screen">
    <h1>Rules of Last Card</h1>
    <p>
        The game starts with 7 cards in each deck, one deck for the player and one for the CPU opponent. 
        
        Players must play either the same suit, or the same number as the previous card played.

        If a player cannot play a card they pick a card from the draw pile. Their turn is now over.
        
        Ace is used as a wild card and can be used on top of any other card. When a player plays an ace, they can use it to change the suit of the cards being played.
        
        When a player has one remaining card in their hand they must say “Last Card.” If they do not, and they play their card on their next turn, they must pick up another 3 cards.
        
        The first person to get rid of their hand is the winner.
        
        If a player plays a 2, the next player must pick up 2 cards. Alternatively, they could play another 2 and the next player would have to pick up 4.

        It also applies if a player plays a 5. The next player picks up 5 cards, or adds another 5 to accumulate.

        If a player plays a 10, the next players turn is skipped.

        If the deck empties and the game is therefore impossible to win, the game will be declared a draw.
    </p>
        <button on:click={toggleHelpScreen} class="return-button">
        Return
        </button>
        </div>
{/if}

{#if state === "playerTurn"}
    <div class="cards">
        {#each oppositionCards as oppositionHandCard}
        <button class="card">
        <img src={oppositionHandCard.image} alt={oppositionHandCard.name} loading="lazy" />
        <!-- <img src="/cards/backcard.png" alt="Back of card" /> -->
        </button>
        {/each}
    </div>
    <div class="card-count">
        <div class="card-counter">{oppositionCardCount}</div>
    </div>
    <div>
        <h1 >player turn</h1>
        <h1>
            turn: {turnCount}
        </h1>
    </div>
    <div class="center">
        <div class="pickup-area">
        <div class="pile-count">
            <div class="pile-counter">{pileCount}</div>
        </div>
        <button on:click = {() => {
            pickup(playerCards);
            state = "opponentTurn";
        }} class="card pickup-pile">
            <img src="/cards/backcard.png" alt="Pickup Card Pile" />
        </button>
        <button class="card">
            <img src={currentCard?.image} alt={currentCard?.name} loading="lazy"/>
        </button>
    </div>
    </div>
    <div class="cards">
        {#each playerCards as playerHandCard}
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
    <div class="card-counter player-card-counter">{playerCardCount}</div>
    </div>
    <button 
    on:click={handleLastCardClick}
    class="last-card-button {lastCardActive ? 'clicked' : ''}" 
    disabled={playerCards.length !== 2} 
    >
        Last Card
    </button>
{/if}


{#if state === 'opponentTurn'} 
    
    <div class="cards">
        {#each oppositionCards as oppositionHandCard}
        <button class="card">
        <img src={oppositionHandCard.image} alt={oppositionHandCard.name} loading="lazy" />
        <!-- <img src="/cards/backcard.png" alt="Back of card" /> -->
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
    <div class="card-counter player-card-counter">{playerCardCount}</div>
    </div>
{/if}

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
    <div class="cards">     
        {#each suits as suit}
            <button 
            on:click={() => (currentCard.suit = suit)}
            on:click={() => (state = "opponentTurn")}
                class="card">
                <h1>{suit}</h1>
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

{#if state === "won"}
    <div class ="win-screen">
        <h1>You Won!</h1>
        <h2>Press the retry button to play again</h2>
        <button on:click={resetGame()} class="retry-button">
            retry
            </button>
    </div>
{/if}

{#if state === "lost"}
    <div class ="loss-screen">
        <h1>You Lost!</h1>
        <h2>Press the retry button to play again</h2>
        <button on:click={resetGame()} class="retry-button">
            retry
            </button>
    </div>
{/if}

{#if state === "draw"}
    <div class ="draw-screen">
        <h1>You Drew!</h1>
        <h2>Press the retry button to play again</h2>
        <button on:click={resetGame()} class="retry-button">
            retry
            </button>
    </div>
{/if}

<style>

.center {
        margin: auto;
        background-color: hsl(122, 92%, 20%);
    }
    .cards {
        display: flex;
        grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
        gap: 8px;
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
    .start-button, .help-button {
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

    .start-button:hover {
        background-color: gold;
    }


    .help-button:hover {
        background-color: red;
    }

    .help-screen {
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
    .card img {
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

    .last-card-button:disabled {
        background-color: grey;
        cursor: not-allowed;
    }

    .last-card-button:not(:disabled):hover {
        background-color: red;
    }

    .last-card-button.clicked {
        background-color: gold;
    }


    .card-count {
        display: flex;
        flex-direction: column;
        align-items: left;
        margin: 0;
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
