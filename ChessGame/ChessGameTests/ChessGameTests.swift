//
//  ChessGameTests.swift
//  ChessGameTests
//
//  Created by jinho on 2022/06/20.
//

import XCTest
@testable import ChessGame

class ChessGameTests: XCTestCase {

    var chessBoard: ChessBoard!

    override func setUpWithError() throws {
        
        chessBoard = ChessBoard()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserScoresWhenInitializeBoard() throws {
        
        // given
        let blackScore = 39 // 8 + 6 + 6 + 5 + 5 + 9
        let whiteScore = 39
        
        // when
        chessBoard.initializeBoard()
        
        // then
        let blackScoreInChessBoard =
        chessBoard.positions.filter{ $0.value.color == .black }
            .map{ $0.value.kind.score }
            .reduce(0, +)
        let whiteScoreInChessBoard =
        chessBoard.positions.filter{ $0.value.color == .black }
            .map{ $0.value.kind.score }
            .reduce(0, +)
        

        XCTAssertEqual(blackScoreInChessBoard, blackScore)
        XCTAssertEqual(whiteScoreInChessBoard, whiteScore)
    }
    
    func testQueenPosion() throws {
        
        // given
        let position = 58
        
        // then
        let whiteQueenPosion = ChessBoardPositionKeys.e8.rawValue
        
        XCTAssertEqual(whiteQueenPosion, position)
    }
    
    func testQueenPropertyWhenInitializeBoard() throws {
        
        // given
        let chessmen = Chessmen(kind: .queen,
                                color: .white)
        
        // when
        chessBoard.initializeBoard()
        
        // then
        let whiteQueen = chessBoard.positions.filter{ $0.value.color == .white && $0.value.kind == .queen }.first!.value
        
        XCTAssertEqual(whiteQueen.color, chessmen.color)
        XCTAssertEqual(whiteQueen.kind.score, chessmen.kind.score)
        XCTAssertEqual(whiteQueen.kind.ranks, chessmen.kind.ranks)
        XCTAssertEqual(whiteQueen.kind.files(whiteQueen.color), chessmen.kind.files(chessmen.color))
    }
    
    func testDisplayPositionOnConsoleWhenInitializeBoard() throws {

        // given
        let expectDiplay = """
        ♜♞♝.♛♝♞♜
        ♟♟♟♟♟♟♟♟
        ........
        ........
        ........
        ........
        ♙♙♙♙♙♙♙♙
        ♖♘♗.♕♗♘♖
        """

        // when
        chessBoard.initializeBoard()

        // then
        let diplayPosition = chessBoard.positions.diplayPositionOnConsole

        XCTAssertEqual(diplayPosition, expectDiplay)
    }
    
    func testPawnMoveablePosition() throws {

        // given
        let expectPawnPositionKeys: [[ChessBoardPositionKeys]] = [[.a6]]

        // then
        let moveablePositionKeys = Chessmen(kind: .pawn,
                                      color: .white).moveablePosition(.a7)

        XCTAssertEqual(expectPawnPositionKeys, moveablePositionKeys)
    }
    
    func testBishopMoveablePosition() throws {

        // given
        let expectBishopPositionKeys: [[ChessBoardPositionKeys]] = [[.b7, .a6],
                                                                    [.d7, .e6, .f5, .g4, .h3]]

        // then
        let moveablePositionKeys = Chessmen(kind: .bishop,
                                            color: .white).moveablePosition(.c8)

        XCTAssertEqual(expectBishopPositionKeys, moveablePositionKeys)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
