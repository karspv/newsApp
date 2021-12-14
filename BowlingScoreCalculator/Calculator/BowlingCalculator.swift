//
//  BowlingCalculator.swift
//  BowlingScoreCalculator
//
//  Created by Admin on 2021-03-30.
//

import Foundation

class BowlingCalculator {
    
    func scoreFor(throwList: [Int]) -> Int {
        var score = 0
        var throwIndex = 0
        var frameThrowIndex = 0
        var frameIndex = 1
        
        for throwScore in throwList {
            frameThrowIndex += 1
            
            if frameThrowIndex == 1 {
                if isStrike(throwScore: throwScore) {
                    score += bonusForStrikeAt(throwIndex: throwIndex, throwList: throwList)
                    frameThrowIndex = 2
                }
            } else if frameThrowIndex == 2 {
                
                if isSpare(throwIndex: throwIndex, throwList: throwList) {
                    score += bonusForSpareAt(throwIndex: throwIndex, throwList: throwList)
                }
            } else {
                print("ERROR! unexpected frameThrowIndex: \(frameThrowIndex)")
            }

            score += throwScore
            throwIndex += 1
            
            if frameThrowIndex == 2 {
                frameIndex += 1
                frameThrowIndex = 0
                
                if frameIndex > 10 {
                    break
                }
            }
        }
        return score
    }
    
    // MARK: - Helpers
    private func isStrike(throwScore: Int) -> Bool {
        return throwScore == 10
    }
    
    private func isSpare(throwIndex: Int, throwList: [Int]) -> Bool {
        if throwList[throwIndex - 1] + throwList[throwIndex] == 10 {
            return true
        }
        return false
    }
    
    private func bonusForSpareAt(throwIndex: Int, throwList: [Int]) -> Int {
        var spareBonus = 0
        
        if throwIndex + 1 < throwList.count {
            spareBonus += throwList[throwIndex + 1]
        }
        return spareBonus
    }
    
    private func bonusForStrikeAt(throwIndex: Int, throwList: [Int]) -> Int {
        
        var bonus = 0
        if (throwIndex + 1) < throwList.count {
            bonus += throwList[throwIndex + 1]
        }
        
        if (throwIndex + 2) < throwList.count {
            bonus += throwList[throwIndex + 2]
        }
        
        return bonus
    }
}
