<script lang="ts">
    import { emoji } from "./emojis"

    type State = 'start' | 'playing' | 'paused' | 'won' | 'lost'

    let state: State = 'start'
</script>
