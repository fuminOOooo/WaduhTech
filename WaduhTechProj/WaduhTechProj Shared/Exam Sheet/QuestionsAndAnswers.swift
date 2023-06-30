//
//  QuestionsAndAnswers.swift
//  WaduhTechProj iOS
//
//  Created by Elvis Susanto on 27/06/23.
//

import Foundation

struct questionsAndCorrectAnswers {
    let questions: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
}

class QuestionsAndAnswers {
    
    var qACA: [questionsAndCorrectAnswers] = []
    
    var correctAnswers : [String] = []
    
    var playerAnswers : [String] = []
    
    var stage: Int = 0 {
        
        didSet {
            
            if (stage == 1) {
                
                playerAnswers = ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-"]
                
                var temp = questionsAndCorrectAnswers(questions: "15 + 90 = ...", answerA: "105", answerB: "95", answerC: "115", answerD: "97")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "12.5 + 10.7 = ...", answerA: "20.2", answerB: "22", answerC: "23.2", answerD: "22.2")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "100 / 3 =  ...", answerA: "33.44", answerB: "33.34", answerC: "34", answerD: "30")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "961 - 619 = ...", answerA: "212", answerB: "270", answerC: "372", answerD: "342")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "888 + 88 + 8 + 8 + 8 = ...", answerA: "8324", answerB: "1024", answerC: "86169", answerD: "1000")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "121 / 11 = ...", answerA: "11", answerB: "10", answerC: "19", answerD: "18")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "131 x 0 x 300 x 4 = ...", answerA: "46", answerB: "0", answerC: "11", answerD: "45")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "23 + 3 / 3 = ...", answerA: "23", answerB: "24", answerC: "25", answerD: "26")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "23 + 53 = ...", answerA: "76", answerB: "73", answerC: "75", answerD: "71")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "123 + 4 - 5 + 67 - 89 = ...", answerA: "97", answerB: "98", answerC: "99", answerD: "100")
                qACA.append(temp)
                
                correctAnswers = ["A","C","B","D","D","A","C","B","A","D"]
                
            } else if (stage == 2) {
                
                playerAnswers = ["-", "-", "-", "-", "-"]
                
                var temp = questionsAndCorrectAnswers(questions: "3^4 / 3^2 = ...", answerA: "3", answerB: "27", answerC: "9", answerD: "81")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "8.56 + 4.82 = ...", answerA: "13.38", answerB: "14.98", answerC: "15.76", answerD: "12.39")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "22, 21, 23, 22, 24, 23, …", answerA: "22", answerB: "23", answerC: "24", answerD: "25")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "1 L = ...", answerA: "100 ml", answerB: "1000 ml", answerC: "10000 ml", answerD: "10 ml")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "The square root of 225 is ...", answerA: "25", answerB: "5", answerC: "15", answerD: "22.5")
                qACA.append(temp)
                
                correctAnswers = ["C","A","D","B","C"]
                
            } else if (stage == 3) {
                
                playerAnswers = ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-"]
                
                var temp = questionsAndCorrectAnswers(questions: "10 / 3 = ...", answerA: "4", answerB: "3.4", answerC: "3.34", answerD: "2.9")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "10 + 99 = ...", answerA: "119", answerB: "100", answerC: "199", answerD: "109")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "23 x 5 = ...", answerA: "115", answerB: "105", answerC: "110", answerD: "100")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "45.5 x 2 = ...", answerA: "91", answerB: "90.5", answerC: "95", answerD: "45")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "54 x 15 = ...", answerA: "210", answerB: "810", answerC: "900", answerD: "510")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "980 - 560 = ...", answerA: "430", answerB: "540", answerC: "450", answerD: "420")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "100 + 500 - 23 + 89 = ...", answerA: "567", answerB: "777", answerC: "666", answerD: "555")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "999 + 99 + 9 = ...", answerA: "1107", answerB: "1117", answerC: "1087", answerD: "1987")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "272 = ...", answerA: "58 x 4", answerB: "136 x 2", answerC: "42 x 6", answerD: "91 x 3")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "20 - 2.5 = ...", answerA: "19.5", answerB: "18", answerC: "17.5", answerD: "18.5")
                qACA.append(temp)
                
                correctAnswers = ["C","D","A","A","B","D","C","A","B","C"]
                
            } else if (stage == 4) {
                
                playerAnswers = ["-", "-", "-", "-", "-"]
                
                var temp = questionsAndCorrectAnswers(questions: "The square root of 1/4 is ...", answerA: "1/2", answerB: "1", answerC: "1/16", answerD: "1/8")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "The absolute value of -26 is ...", answerA: "26", answerB: "-26", answerC: "0", answerD: "1")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "5^3 = ...", answerA: "55", answerB: "625", answerC: "25", answerD: "125")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "1 KM = ...", answerA: "1000 dm", answerB: "1000 cm", answerC: "1000 m", answerD: "1000 mm")
                qACA.append(temp)
                
                temp = questionsAndCorrectAnswers(questions: "1 l = ...", answerA: "10 cl", answerB: "10 dl", answerC: "100 ml", answerD: "10 hl")
                qACA.append(temp)
                
                correctAnswers = ["A","A","D","C","B"]
                
            }
            
            
        }
    }
    
}
