

func mediumAIGetEval(board: Board) -> Double{
    var whitePieceValue = 0.0
    var blackPieceValue = 0.0
    for x in 0..<board.colum{
        for y in 0..<board.rows{
            if (board.getPieceAt(x: x, y: y) == 1){
                whitePieceValue += 1
                if (x == 0 || x == board.colum-1){
                    whitePieceValue += 2
                }
                if (y == 0 || y == board.colum-1){
                    whitePieceValue += 2
                }
            }
            if (board.getPieceAt(x: x, y: y) == 2){
                blackPieceValue += 1
                if (x == 0 || x == board.colum-1){
                    blackPieceValue += 2
                }
                if (y == 0 || y == board.rows-1){
                    blackPieceValue += 2
                }
            }
        }
    }
    return whitePieceValue-blackPieceValue
}


func mediumAIGetMinimaxEval(board: Board, depth: Int, maxDepth: Int, move: [Int], alpha: Double, beta: Double) -> Double{
     /// gets the eval of the board 'board' by searching until 'depth' == 'maxDepth'. Gets it after the move 'move' has been played. This one sorts the moves it searches to hopefully have more pruning from alpha beta pruning.
    // make a mutable copy of board, alpha and beta
    var board = board
    var alpha = alpha
    var beta = beta
    // simulate the move
    board.doMove(x: move[0], y: move[1])
    // if over then return a value depending on who wins
    if (board.isGameOver()){
        // these numbers are closer to 0 than that used as a default value that hasnt been updated yet so even if this position is very bad its better than no position at all
        // also the closer it is (depth being smaller) should be consindered better than if its further away so if it can win in 2 moves or 10 moves it chooses to win in 2 move
        switch board.gameWinner{
            case 0:
                // drawn
                return 0
            case 1:
                // white won
                return Double(9999999999-depth)
            case 2:
                // black won
                return Double(-9999999999+depth)
            default:
                // shouldnt get to this but if does then return 0
                return 0
        }
    }
    if (depth+1 >= maxDepth){
        // if the depth == maxDepth then get the value of this position and return it
        return mediumAIGetEval(board: board)
    }
    // get the legal moves
    let legalMoves = board.getLegalMoves()
    // set the best eval to really bad so when it looks at the first move it is garenteed to be better than the bestEval so it has some move that is the best
    var bestEval: Double = board.playerTurn ? -9999999999 : 99999999999
    // look through each move
    for move in legalMoves{
        // get the eval of the next position
        // if the eval after this move is some amount worse than the bestEval found then skip this move
        let newEval: Double = mediumAIGetMinimaxEval(board: board, depth: depth+1, maxDepth: maxDepth, move: move, alpha: alpha, beta: beta)
        // if the newEval is better (greater if white, smaller if black) than the bestEval then make the best eval the new eval
        if (board.playerTurn){
            bestEval = max(bestEval, newEval)
            if (bestEval > beta){
                break
            }
            alpha = max(bestEval, alpha)
        }
        else{
            bestEval = min(bestEval, newEval)
            if (bestEval < alpha){
                break
            }
            beta = min(bestEval, beta)
        }
    }
    // return the best evaluation it has found
    return bestEval
}

func mediumAIGetBestMove(board: Board) -> [Int]{
    // for each legal move, gets the evaluation from getMinimaxEval and if this move it better than the previous move then this becomes the best move and its eval becomes the best eval
    let legalMoves = board.getLegalMoves()
    var bestMove = [0, 0]
    // white is maximising so starts with a very low best eval so when any move is checked it is greater and will become the next bestMove and bestEval. Black is the opposite
    var bestEval: Double = board.playerTurn ? -9999999999 : 99999999999
    // set alpha and beta for alpha beta pruning
    let alpha: Double = -9999999999
    let beta: Double = 99999999999
    // if the newEval is better than the bestEval then set the bestEval to the newEval and bestMove to the newMove. If newEval == bestEval then randomly chooses one of them
    for move in legalMoves{
        // get the eval from the minimax function
        let newEval = mediumAIGetMinimaxEval(board: board, depth: 0, maxDepth: 2, move: move, alpha: alpha, beta: beta)
        if (board.playerTurn){
            if (newEval > bestEval || (newEval == bestEval && Int.random(in: 0..<2) == 0)){
                bestMove = move
                bestEval = newEval
            }
        }
        else{
            if (newEval < bestEval || (newEval == bestEval && Int.random(in: 0..<2) == 0)){
                bestMove = move
                bestEval = newEval
            }
        }
    }
    return bestMove
}

func mediumAIGetBestMove2(board: Board) -> [Int]{
    // for each legal move, gets the evaluation from getMinimaxEval and if this move it better than the previous move then this becomes the best move and its eval becomes the best eval
    let legalMoves = board.getLegalMoves()
    var bestMove = [0, 0]
    // white is maximising so starts with a very low best eval so when any move is checked it is greater and will become the next bestMove and bestEval. Black is the opposite
    var bestEval: Double = board.playerTurn ? -9999999999 : 99999999999
    // set alpha and beta for alpha beta pruning
    let alpha: Double = -9999999999
    let beta: Double = 99999999999
    // if the newEval is better than the bestEval then set the bestEval to the newEval and bestMove to the newMove. If newEval == bestEval then randomly chooses one of them
    for move in legalMoves{
        // get the eval from the minimax function
        let newEval = mediumAIGetMinimaxEval(board: board, depth: 0, maxDepth: 4, move: move, alpha: alpha, beta: beta)
        if (board.playerTurn){
            if (newEval > bestEval || (newEval == bestEval && Int.random(in: 0..<2) == 0)){
                bestMove = move
                bestEval = newEval
            }
        }
        else{
            if (newEval < bestEval || (newEval == bestEval && Int.random(in: 0..<2) == 0)){
                bestMove = move
                bestEval = newEval
            }
        }
    }
    return bestMove
}



func mediumAIGetBestMove3(board: Board) -> [Int]{
    // for each legal move, gets the evaluation from getMinimaxEval and if this move it better than the previous move then this becomes the best move and its eval becomes the best eval
    let legalMoves = board.getLegalMoves()
    var bestMove = [0, 0]
    // white is maximising so starts with a very low best eval so when any move is checked it is greater and will become the next bestMove and bestEval. Black is the opposite
    var bestEval: Double = board.playerTurn ? -9999999999 : 99999999999
    // set alpha and beta for alpha beta pruning
    let alpha: Double = -9999999999
    let beta: Double = 99999999999
    // if the newEval is better than the bestEval then set the bestEval to the newEval and bestMove to the newMove. If newEval == bestEval then randomly chooses one of them
    for move in legalMoves{
        // get the eval from the minimax function
        let newEval = hardAIGetMinimaxEval(board: board, depth: 0, maxDepth: 2, move: move, alpha: alpha, beta: beta)
        if (board.playerTurn){
            if (newEval > bestEval || (newEval == bestEval && Int.random(in: 0..<2) == 0)){
                bestMove = move
                bestEval = newEval
            }
        }
        else{
            if (newEval < bestEval || (newEval == bestEval && Int.random(in: 0..<2) == 0)){
                bestMove = move
                bestEval = newEval
            }
        }
    }
    return bestMove
}