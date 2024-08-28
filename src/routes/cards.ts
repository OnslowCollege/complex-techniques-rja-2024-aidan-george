export interface CardInfo {
    suit: string;
    name: string;
    image: string;
}

export const cards: CardInfo[] = [];
export const aces: CardInfo[] = [];

const suits: string[] = ['clubs', 'diamonds', 'hearts', 'spades'];
const names: string[] = ['ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king'];

// Generate cards for each suit and name
for (const suit of suits) {
    for (const name of names) {
        const image = `/cards/${name}${suit}.png`;
        // Create the card object and push it to the array
        cards.push({ suit: suit, name: name, image: image });
    }
    const name = "ace"
    const image = `/cards/${name}${suit}.png`;
    // Create the card object and push it to the array
    aces.push({ suit: suit, name: name, image: image });
}
