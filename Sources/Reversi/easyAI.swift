

func easyAIGetBestMove(board: Board) -> [Int]{
    /// gets a move by looking 1 move in the future and the one that gets the most tiles is the one is does
    let legalMoves = board.getLegalMoves()
    
    // bestEvalaution will store the best evaluation, bestMove will store the move that got bestEvalaution
    // start with a very negative number if its whites turn else a very positive number
    var bestEvaluation = board.playerTurn ? -9999999 : 9999999
    var bestMove = [0, 0]
    for move in legalMoves{
        // make a copy of the board so the main board wont be changed
        var boardCopy = board
        // do the move on the board copy
        boardCopy.doMove(x: move[0], y: move[1])
        // count the white and black pieces
        var whitePieces = 0
        var blackPieces = 0
        for x in 0..<board.colum{
            for y in 0..<board.rows{
                let piece = boardCopy.getPieceAt(x: x, y: y)
                switch piece{
                    case 1: whitePieces += 1
                    case 2: blackPieces += 1
                    default: continue
                }
            }
        }
        // get the difference in pieces as the evaluation so it wants to get more pieces and it wants to make its opponent have less pieces
        let currentEvaluation = whitePieces-blackPieces
        // if this evaluation is better than the bestEvaluation then make this the best move. If its the same number then make it randomly choose one
        if ((board.playerTurn && currentEvaluation > bestEvaluation) || (!board.playerTurn && currentEvaluation < bestEvaluation) || (currentEvaluation == bestEvaluation && Int.random(in: 0..<2) == 0)){
            // make this move the bestMove and bestEvaluation
            bestMove = move
            bestEvaluation = currentEvaluation
        }
    }
    //return the best move
    return bestMove
}
