<script lang="ts">
    import { emoji } from "./emojis"

    type State = 'start' | 'playing' | 'paused' | 'won' | 'lost'
</script>

start (idle)
playing
playing.matching
paused 
won 
lost

data-state={state}