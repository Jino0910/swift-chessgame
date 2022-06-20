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

    func testUserScores() throws {
        
        // given
        let initialBoardUserScore = 39 // 8 + 6 + 6 + 5 + 5 + 9
        
        // when
        chessBoard.initialBoard()
        
        // then
        XCTAssertEqual(chessBoard.blackUser?.score, initialBoardUserScore)
        XCTAssertEqual(chessBoard.whiteUser?.score, initialBoardUserScore)
    }
    
    func testChessmenCount() throws {
        
        // given
        let pawn = 8
        let bishop = 2
        let knight = 2
        let luke = 2
        let queen = 1
        
        // when
        chessBoard.initialBoard()
        
        // then
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .pawn }.count, pawn)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .knight }.count, knight)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .bishop }.count, bishop)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .luke }.count, luke)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .queen }.count, queen)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .pawn }.count, pawn)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .knight }.count, knight)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .bishop }.count, bishop)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .luke }.count, luke)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .queen }.count, queen)
    }
    
    func testChessmenLocation() throws {
        
        // given
        let pawnWhite = ["A7", "B7", "C7", "D7", "E7", "F7", "G7", "H7"]
        let bishopWhite = ["C8", "F8"]
        let knightWhite = ["A8", "H8"]
        let lukeWhite = ["B8", "G8"]
        let queenWhite = ["E8"]
        let pawnBlack = ["A2", "B2", "C2", "D2", "E2", "F2", "G2", "H2"]
        let bishopBlack = ["C1", "F1"]
        let knightBlack = ["A1", "H1"]
        let lukeBlack = ["B1", "G1"]
        let queenBlack = ["E1"]
        
        // when
        chessBoard.initialBoard()
        
        // then
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .pawn }.map{ $0.location }, pawnBlack)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .knight }.map{ $0.location }, knightBlack)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .bishop }.map{ $0.location }, bishopBlack)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .luke }.map{ $0.location }, lukeBlack)
        XCTAssertEqual(chessBoard.blackUser?.chessmens.filter{ $0.kind == .queen }.map{ $0.location }, queenBlack)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .pawn }.map{ $0.location }, pawnWhite)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .knight }.map{ $0.location }, knightWhite)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .bishop }.map{ $0.location }, bishopWhite)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .luke }.map{ $0.location }, lukeWhite)
        XCTAssertEqual(chessBoard.whiteUser?.chessmens.filter{ $0.kind == .queen }.map{ $0.location }, queenWhite)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
