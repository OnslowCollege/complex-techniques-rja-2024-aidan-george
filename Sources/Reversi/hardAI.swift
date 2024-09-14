
import Foundation


func pieceCount(board: Board) -> Double{
    var whitePieces = 0.0
    var blackPieces = 0.0
    for x in 0..<board.colum{
        for y in 0..<board.rows{
            let piece = board.getPieceAt(x: x, y: y)
            if (piece == 1){
                whitePieces += 1
            }
            if (piece == 2){
                blackPieces += 1
            }
        }
    }
    return whitePieces-blackPieces
}


func cornerEdgeValue(board: Board) -> Double{
    var whitePieces = 0.0
    var blackPieces = 0.0
    for x in 0..<board.colum{
        let piece = board.getPieceAt(x: x, y: 0)
        if (piece == 1){
            whitePieces += 1
        }
        if (piece == 2){
            blackPieces += 1
        }
    }
    for x in 0..<board.colum{
        let piece = board.getPieceAt(x: x, y: board.colum-1)
        if (piece == 1){
            whitePieces += 1
        }
        if (piece == 2){
            blackPieces += 1
        }
    }
    for y in 0..<board.rows{
        let piece = board.getPieceAt(x: 0, y: y)
        if (piece == 1){
            whitePieces += 1
        }
        if (piece == 2){
            blackPieces += 1
        }
    }
    for y in 0..<board.rows{
        let piece = board.getPieceAt(x: board.rows-1, y: y)
        if (piece == 1){
            whitePieces += 1
        }
        if (piece == 2){
            blackPieces += 1
        }
    }
    return whitePieces-blackPieces
}


func adjacentCornerEdgeValue(board: Board) -> Double{
    /// gets the amount of pieces 1 away from the corners and edges
    var whitePieces = 0.0
    var blackPieces = 0.0
    for x in 0..<board.colum{
        let piece = board.getPieceAt(x: x, y: 1)
        if (piece == 1){
            if (x == 0 || x == board.colum-1){
                whitePieces += 1
            }
            whitePieces += 1
        }
        if (piece == 2){
            if (x == 0 || x == board.colum-1){
                blackPieces += 1
            }
            blackPieces += 1
        }
    }
    for x in 0..<board.colum{
        let piece = board.getPieceAt(x: x, y: board.colum-2)
        if (piece == 1){
            if (x == 0 || x == board.colum-1){
                whitePieces += 1
            }
            whitePieces += 1
        }
        if (piece == 2){
            if (x == 0 || x == board.colum-1){
                blackPieces += 1
            }
            blackPieces += 1
        }
    }
    for y in 0..<board.rows{
        let piece = board.getPieceAt(x: 1, y: y)
        if (piece == 1){
            if (y == 0 || y == board.rows-1){
                whitePieces += 1
            }
            whitePieces += 1
        }
        if (piece == 2){
            if (y == 0 || y == board.rows-1){
                blackPieces += 1
            }
            blackPieces += 1
        }
    }
    for y in 0..<board.rows{
        let piece = board.getPieceAt(x: board.rows-2, y: y)
        if (piece == 1){
            if (y == 0 || y == board.rows-1){
                whitePieces += 1
            }
            whitePieces += 1
        }
        if (piece == 2){
            if (y == 0 || y == board.rows-1){
                blackPieces += 1
            }
            blackPieces += 1
        }
    }
    return whitePieces-blackPieces
}


func getStabilityCount(board: Board) -> Double{
    /// gets how many pieces are stable where pieces that can never be flipped over are worth 3, and other pieces are worth 0
    // for a piece to be stable it needs to be adjacent to a stable piece on both horizontal and verticle directions.
    
    // store where corners are and which directionit is to the center
    var whiteStablePieces = 0
    var blackStablePieces = 0
    let corners = [[0, 0, 1, 1], [0, board.rows-1, 1, -1], [board.colum-1, 0, -1, 1], [board.colum-1, board.rows-1, -1, -1]]
    for corner in corners{
        let colour = board.getPieceAt(x: corner[0], y: corner[1])
        if (colour != 0){
            var maxX = 0
            var maxY = 0
            // theres something in this corner so needs to check its adjacent tiles
            // check downwards untill it finds a different colour (other person/empty)
            for dy in 1..<board.rows{
                if (colour == board.getPieceAt(x: corner[0], y: corner[1]+dy*corner[3])){
                    // same colour so continue
                }
                else{
                    // different colour so break after setting the max y to dy
                    maxY = dy
                    break
                }
            }
            // same thing but on the x axis
            for dx in 1..<board.rows{
                if (colour == board.getPieceAt(x: corner[0]+dx*corner[2], y: corner[1])){
                    // same colour so continue
                }
                else{
                    // different colour so break after setting the max x to dx
                    maxX = dx
                    break
                }
            }
            
            if (colour == 1){
                whiteStablePieces += maxX+maxY-1
            }
            else{
                blackStablePieces += maxX+maxY-1
            }
            /* loop in a triangle like
            0 0 0 0
            0 0 0
            0 0
            0
            or
            0 0 0 0 0
            0 0 0 0
            0 0 0
            These wont include edges/corners
            */
            // print(maxX, maxY)
            if (maxX < 1){
                    continue
                }
            for dx in 1..<maxX{
                // check in case maxY-dx is less than 1
                if (maxY-dx < 1){
                    break
                }
                for dy in 1..<min(max(maxX, maxY), maxY-dx+1){
                    // print(corner[0]+dx*corner[2], corner[1]+dy*corner[3])
                    // if its the same coloured piece here then increase the stable piece count by 1
                    if (colour == board.getPieceAt(x: corner[0]+dx*corner[2],  y: corner[1]+dy*corner[3])){
                        if (colour == 1){
                            whiteStablePieces += 1
                        }
                        else {
                            blackStablePieces += 1
                        }
                    }
                    // since theres not the same piece here, decrease maxY and break to the next dx value
                    else{
                        maxY = dy+dx
                        break
                    }
                }
            }
        }
    }

    // print("stable white pieces \(whiteStablePieces)")
    // print("stable black pieces \(blackStablePieces)")
    return Double(whiteStablePieces-blackStablePieces)
}


func hardAIGetEval(board: Board) -> Double{
    // more pieces is good but not too important as they can get flipped very quickly, so x0.2 per piece
    let boardPieceCount = 0.2*pieceCount(board: board)
    // corners and edges are very good so x1.3
    let boardCornerEdgeValue = 1.3*cornerEdgeValue(board: board)
    // adjacent to corners and edges are bad, times by -1 to show that its bad
    let boardAdjacentCornerEdgeValue = -2.0*adjacentCornerEdgeValue(board: board)
    // stable pieces are very good as they cant be taken back over, x3 as they are very good and will never be bad
    let boardStablePieceCount = 100*getStabilityCount(board: board)

    // return the sum of values
    return boardPieceCount+boardCornerEdgeValue+boardAdjacentCornerEdgeValue+boardStablePieceCount
}


func hardAIMinimaxJudgeMove(board: Board, move: [Int]) -> Double{
    /// return importance of the move
    // make a mutable board
    var board = board
    board.doMove(x: move[0], y: move[1])
    // will return the eval of this board but it needs to be so that if its black to play then it will return larger numbers for black if the moves good which can be done by multipling the eval by -1 if its blacks turn
    let eval = hardAIGetEval(board: board)
    // if its whites turn return eval otherwise -eval for blacks turn
    return board.playerTurn ? eval : -eval
}


func hardAIGetMinimaxEval(board: Board, depth: Int, maxDepth: Int, move: [Int], alpha: Double, beta: Double) -> Double{
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
        return hardAIGetEval(board: board)
    }
    // get the legal moves
    let legalMoves = board.getLegalMoves()
    // set the best eval to really bad so when it looks at the first move it is garenteed to be better than the bestEval so it has some move that is the best
    var bestEval: Double = board.playerTurn ? -9999999999 : 99999999999
    // look through each move
    for move in legalMoves{
        // get the eval of the next position
        // if the eval after this move is some amount worse than the bestEval found then skip this move
        let instantEval = hardAIMinimaxJudgeMove(board: board, move: move)
        if ((board.playerTurn && instantEval < bestEval-5) || (!board.playerTurn && instantEval > bestEval+5)){
            // the move seems too bad instantly so skip searching this line
            continue
        }
        let newEval: Double = hardAIGetMinimaxEval(board: board, depth: depth+1, maxDepth: maxDepth, move: move, alpha: alpha, beta: beta)
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


func hardAIGetBestMove(board: Board) -> [Int]{
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
        let newEval = hardAIGetMinimaxEval(board: board, depth: 0, maxDepth: 4, move: move, alpha: alpha, beta: beta)
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