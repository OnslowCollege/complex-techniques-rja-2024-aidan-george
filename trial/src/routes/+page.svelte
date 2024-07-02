<script lang="ts">
    import { emoji } from "./emojis"

    type State = 'start' | 'playing' | 'paused' | 'won' | 'lost'

    let state: State = 'start'
    let size = 20
    let grid = createGrid()

    function createGrid() {
        let cards = new Set<string>()
        let maxSize = size / 2

        while (cards.size < maxSize) {
            const randomIndex = Math.floor(Math.random() * emoji.length)
            cards.add(emoji[randomIndex])
        }

        return shuffle([...cards, ...cards])
    }

    function shuffle<Items>(array: Items[]) {
        return array.sort(() => Math.random() - 0.5 )

    }

    console.log(grid)
</script>
