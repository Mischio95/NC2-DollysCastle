//
//  Utilities.swift
//  Cuphella
//
//  Created by Michele Trombone  on 09/12/22.
//

import Foundation
import UIKit


var vibrationFlag = false
var chooseInput = 0
var chooseSound = true
var chooseVibration = true

func UpdateHightScore(with score: Int)
{
    var newScore = LoadScore()
    newScore.append(score)
    newScore.sort()
    newScore.reverse()
    if newScore.count == 10
    {
        newScore.remove(at: newScore.count-1)
    }
    
    UserDefaults.standard.set(newScore, forKey: "Score List")
}


func LoadScore() -> [Int]
{
    var scores : [Int] = [0]
    
    if let rowData = UserDefaults.standard.object(forKey: "Score List")
    {
        if let savedScores = rowData as? [Int]
        {
            scores = savedScores
        }
    }
    scores.sort()
    scores.reverse()
    
    let vectorWithoutDuplicate = scores.removingDuplicates()
    
    return vectorWithoutDuplicate
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}



