//
//  ViewController.swift
//  TicTacToe
//
//  Created by Edward Lee on 2020-06-15.
//  Copyright © 2020 Edward Lee. All rights reserved.
//  Using Bensound music. This project is not for financial purposes. Please don't sue me for the $0 of profit I made from this project

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var CPUScore: UILabel!
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topMiddleLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var bottomMiddleLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var topLabel: UIButton!
    @IBOutlet weak var bottomLabel: UIButton!
    var pScore = 0, cScore = 0
    var turn = 1
    var goFirst="player"
    var board = [[-1,-2,-3], [-4,-5,-6], [-7,-8,-9]]
    var expect = "game"
    var music = AVAudioPlayer ()
    
    // - MARK: Post-Game Buttons
    @IBAction func nextButton(_ sender: Any) {
        if expect=="next" {
            if goFirst=="player" {
                goFirst="cpu"
                turn=0
                expect = "ai"
            }
            else {
                goFirst="player"
                turn=1
            }
            clearBoard()
        }
    }
    @IBAction func clearButton(_ sender: Any) {
        if expect=="next" {
            pScore=0
            playerScore.text=String(pScore)
            cScore=0
            CPUScore.text=String(cScore)
            clearBoard ()
            goFirst = "player"
            turn=1
        }
    }
    func clearBoard () {
        board = [[-1,-2,-3], [-4,-5,-6], [-7,-8,-9]]
        topLeftLabel.text=""
        topMiddleLabel.text=""
        topRightLabel.text=""
        leftLabel.text=""
        middleLabel.text=""
        rightLabel.text=""
        bottomLeftLabel.text=""
        bottomMiddleLabel.text=""
        bottomRightLabel.text=""
        firstLabel.text="Who Will Win?"
        topLabel.setTitle("", for: .normal)
        bottomLabel.setTitle("", for: .normal)
        if turn==0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                self.aiTurn ()
                self.expect = "game"
            }
        }
        else {
            expect = "game"
        }
    }
    
    // - MARK: Checks Winner
    func checkWinner () {
        var winner = -1
        for x in 0...2 {
            if board[x][0]==0 && board[x][1]==0 && board[x][2]==0 {
                winner = 0
                break
            }
            else if board[x][0]==1 && board[x][1]==1 && board[x][2]==1 {
                winner = 1
                break
            }
            else if board[0][x]==0 && board[1][x]==0 && board[2][x]==0 {
                winner = 0
                break
            }
            else if board[0][x]==1 && board[1][x]==1 && board[2][x]==1 {
                winner = 1
                break
            }
        }
        if winner == -1 {
            if (board[0][0]==0 && board[1][1]==0 && board[2][2]==0) || (board[0][2]==0 && board[1][1]==0 && board[2][0]==0) {
                winner=0
            }
            else if (board[0][0]==1 && board[1][1]==1 && board[2][2]==1) || (board[0][2]==1 && board[1][1]==1 && board[2][0]==1) {
                winner=1
            }
        }
        if winner == 0 {
            expect="next"
            pScore+=1
            playerScore.text=String(pScore)
            firstLabel.text="You Won!"
            topLabel.setTitle("Next Game", for: .normal)
            bottomLabel.setTitle("Clear Score", for: .normal)
        }
        else if winner == 1 {
            expect="next"
            cScore+=1
            CPUScore.text=String(cScore)
            firstLabel.text="You Lost!"
            topLabel.setTitle("Next Game", for: .normal)
            bottomLabel.setTitle("Clear Score", for: .normal)
        }
    }
    
    // - MARK: The board is updated
    func play (row: Int, col: Int) {
        board[row][col]=(-turn%2)+1
        turn+=1
        checkWinner()
        if firstLabel.text=="Who Will Win?" && ((goFirst=="player" && turn==10) || (goFirst=="cpu" && turn==9)) {
            expect="next"
            firstLabel.text="You Tied!"
            topLabel.setTitle("Next Game", for: .normal)
            bottomLabel.setTitle("Clear Score", for: .normal)
        }
    }
    
    // - MARK: Player makes a move
    @IBAction func topLeftButton(_ sender: Any) {
        if expect=="game" && board[0][0] < 0 {
            if turn%2==1 {
                topLeftLabel.text="X"
            }
            else {
                topLeftLabel.text="O"
            }
            play(row:0, col:0)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func topMiddleButton(_ sender: Any) {
        if expect=="game" && board[0][1] < 0 {
            if turn%2==1 {
                topMiddleLabel.text="X"
            }
            else {
                topMiddleLabel.text="O"
            }
            play(row:0, col:1)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func topRightButton(_ sender: Any) {
        if expect=="game" && board[0][2] < 0 {
            if turn%2==1 {
                topRightLabel.text="X"
            }
            else {
                topRightLabel.text="O"
            }
            play(row:0, col:2)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func leftButton(_ sender: Any) {
        if expect=="game" && board[1][0] < 0 {
            if turn%2==1 {
                leftLabel.text="X"
            }
            else {
                leftLabel.text="O"
            }
            play(row:1, col:0)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func middleButton(_ sender: Any) {
        if expect=="game" && board[1][1] < 0 {
            if turn%2==1 {
                middleLabel.text="X"
            }
            else {
                middleLabel.text="O"
            }
            play(row:1, col:1)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func rightButton(_ sender: Any) {
        if expect=="game" && board[1][2] < 0 {
            if turn%2==1 {
                rightLabel.text="X"
            }
            else {
                rightLabel.text="O"
            }
            play(row:1, col:2)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func bottomLeftButton(_ sender: Any) {
        if expect=="game" && board[2][0] < 0 {
            if turn%2==1 {
                bottomLeftLabel.text="X"
            }
            else {
                bottomLeftLabel.text="O"
            }
            play(row:2, col:0)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func bottomMiddleButton(_ sender: Any) {
        if expect=="game" && board[2][1] < 0 {
            if turn%2==1 {
                bottomMiddleLabel.text="X"
            }
            else {
                bottomMiddleLabel.text="O"
            }
            play(row:2, col:1)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    @IBAction func bottomRightButton(_ sender: Any) {
        if expect=="game" && board[2][2] < 0 {
            if turn%2==1 {
                bottomRightLabel.text="X"
            }
            else {
                bottomRightLabel.text="O"
            }
            play(row:2, col:2)
            if expect=="game" {
                expect = "ai"
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    self.aiTurn ()
                }
            }
        }
    }
    
    // - MARK: AI Plays
    func aiTurn () {
        var randNum=0
        
        if turn==0 {
            randNum=Int.random(in: 0...2)
            if randNum==0 {
                middleLabel.text="O"
                expect = "game"
                play(row:1, col:1)
            }
            else {
                randNum=Int.random(in:0...3)
                if randNum==0 {
                    topLeftLabel.text="O"
                    expect = "game"
                    play(row:0, col:0)
                }
                else if randNum==1 {
                    topRightLabel.text="O"
                    expect = "game"
                    play(row:0, col:2)
                }
                else if randNum==2 {
                    bottomLeftLabel.text="O"
                    expect = "game"
                    play(row:2, col:0)
                }
                else {
                    bottomRightLabel.text="O"
                    expect = "game"
                    play(row:2, col:2)
                }
            }
        }
        else if turn==2 && goFirst=="player" && Int.random(in: 1...5)>1 {
            randNum=Int.random(in: 1...4)
            if randNum==1 {
                topLeftLabel.text="O"
                expect = "game"
                play(row:0, col:0)
            }
            else if randNum==2 {
                topRightLabel.text="O"
                expect = "game"
                play(row:0, col:2)
            }
            else if randNum==3 {
                bottomLeftLabel.text="O"
                expect = "game"
                play(row:2, col:0)
            }
            else {
                bottomRightLabel.text="O"
                expect = "game"
                play(row:2, col:2)
            }
        }
        else {
            var blankNum = 0
            for x in 0...2 {
                for y in 0...2 {
                    if board[x][y] < 0 {
                        blankNum+=1
                    }
                }
            }
            var played = false
            if board[0][2]<0 && ((board[0][0]==board[0][1]) || (board[1][2]==board[2][2]) || (board[1][1]==board[2][0])) {
                topRightLabel.text="O"
                expect = "game"
                play(row:0, col:2)
                played=true
            }
            else if board[1][2]<0 && ((board[1][0]==board[1][1]) || (board[0][2]==board[2][2])) {
                rightLabel.text="O"
                expect = "game"
                play(row:1, col:2)
                played=true
            }
            else if board[2][2]<0 && ((board[2][0]==board[2][1]) || (board[0][2]==board[1][2]) || (board[1][1]==board[0][0])) {
                bottomRightLabel.text="O"
                expect = "game"
                play(row:2, col:2)
                played=true
            }
            else if board[0][0]<0 && ((board[0][2]==board[0][1]) || (board[1][1]==board[2][2]) || (board[2][0]==board[1][0])) {
                topLeftLabel.text="O"
                expect = "game"
                play(row:0, col:0)
                played=true
            }
            else if board[1][0]<0 && ((board[1][2]==board[1][1]) || (board[0][0]==board[2][0])) {
                leftLabel.text="O"
                expect = "game"
                play(row:1, col:0)
                played=true
            }
            else if board[2][0]<0 && ((board[2][2]==board[2][1]) || (board[0][0]==board[1][0]) || (board[1][1]==board[0][2])) {
                bottomLeftLabel.text="O"
                expect = "game"
                play(row:2, col:0)
                played=true
            }
            else if board[0][1]<0 && ((board[0][2]==board[0][0]) || (board[1][1]==board[2][1])) {
                topMiddleLabel.text="O"
                expect = "game"
                play(row:0, col:1)
                played=true
            }
            else if board[1][1]<0 && ((board[1][2]==board[1][0]) || (board[0][1]==board[2][1]) || (board[0][0]==board[2][2]) || (board[2][0]==board[0][2])) {
                middleLabel.text="O"
                expect = "game"
                play(row:1, col:1)
                played=true
            }
            else if board[2][1]<0 && ((board[2][2]==board[2][0]) || (board[0][1]==board[1][1])) {
                bottomMiddleLabel.text="O"
                expect = "game"
                play(row:2, col:1)
                played=true
            }
            if !played {
                randNum=Int.random(in: 1...blankNum)
                for x in 0...2 {
                    for y in 0...2 {
                        if board[x][y] < 0 {
                            randNum-=1
                        }
                        if randNum==0 {
                            if x==0 && y==0 {
                                topLeftLabel.text="O"
                            }
                            else if x==0 && y==1 {
                                topMiddleLabel.text="O"
                            }
                            else if x==0 && y==2 {
                                topRightLabel.text="O"
                            }
                            else if x==1 && y==0 {
                                leftLabel.text="O"
                            }
                            else if x==1 && y==1 {
                                middleLabel.text="O"
                            }
                            else if x==1 && y==2 {
                                rightLabel.text="O"
                            }
                            else if x==2 && y==0 {
                                bottomLeftLabel.text="O"
                            }
                            else if x==2 && y==1 {
                                bottomMiddleLabel.text="O"
                            }
                            else if x==2 && y==2 {
                                bottomRightLabel.text="O"
                            }
                            expect = "game"
                            play(row:x, col:y)
                            played=true
                            break
                        }
                    }
                    if played {
                        break
                    }
                }
            }
        }
    }
    
    // - MARK: Music
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            music = try AVAudioPlayer (contentsOf: URL.init (fileURLWithPath: Bundle.main.path(forResource:"TicTacToeMusic", ofType:"mp3")!))
            music.prepareToPlay()
            music.numberOfLoops = -1
            music.play()
        } catch {}
    }
}

