import Foundation

//given a 2D board of characters and a word, find if the word exists
//in the grid

//extension to be able to access each character of string like an array
extension StringProtocol {
    
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension LosslessStringConvertible {
    var string: String { return String(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}




//this function allows us to find the steps between each point
func steps(sequence: [(Int,Int,Character)]) -> String {
    //add 1 to this for number of steps to take
    var number = 0
    var reversed = sequence.enumerated().reversed()
    var extraSteps = 0
    var letters:[Character] = []
    //iterate through each point in the sequence
    //iterate backwards
    
    for point in 0..<sequence.count-1 {
        if(((reversed[point].element.0)-(reversed[point+1].element.0)==1)||((reversed[point].element.0)-(reversed[point+1].element.0)==0)){
            if(((reversed[point].element.1)-(reversed[point+1].element.1)==1)||((reversed[point].element.1)-(reversed[point+1].element.1)==0)){
                
                number += 1
                
                letters.append(reversed[point].element.2)
                
                
            }//end if
            else {
                extraSteps = ((reversed[point].element.1)-(reversed[point+1].element.1))
                number += extraSteps
            }
            
            letters.append(reversed[point].element.2)
            
        }//end if
        else {
            extraSteps = ((reversed[point].element.0)-(reversed[point+1].element.0))
            number += extraSteps
        }
    }//end for
    
    letters.reverse()
    return String(letters)
    
}//end func









//exists(board, "SEE") returns true

let myBoard = [

    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"],

]

//thic function will check to see if unputted string is in the board
func exists(board:[[String]], word:String) -> Bool {
    
    
    var exists = false
    var currentIndex = 0
    var lastIndex = 0
    var row = 0
    var letterCount = 0
    var indexArray:[(Int,Int,Character)] = []
    
    
    
    //check that the differences in index numbers is not greater than 1
    //replace the letter with a * if it is a match to prevent from being used again
    
    //create copy of board
    var boardCopy = board
    
    //loop through each letter in the string
    for letter in word {
        
        //loop through arrays
        for array in boardCopy {
            //loop through each letter in the array
            for char in array {
                
                if(char == String(letter)) {
                    currentIndex = array.firstIndex(of: String(char))!
                    boardCopy[row][currentIndex] = "*"
                    
                    indexArray.append((row,currentIndex,letter))
                    
                    //check if there is another instance
                    if(array.contains(String(char))){
                        let currentIndex2 = array.lastIndex(of: String(char))!
                        boardCopy[row][currentIndex2] = "*"
                        
                        
                        indexArray.append((row,currentIndex2,letter))
                        
                        //check if there is another instance
                        if(array.contains(String(char))){
                            
                            
                            
                        }//end if
                        
                        
                    }//end if
                    
                    
                    
                    
                    
                    
                    exists = true
                    print(char)
                }
                
                
                
            }//end for
            row += 1
        }//end for
        row = 0
        letterCount += 1
        
    }//end for
    
    var uniqueArray:[(Int,Int,Character)] = []
    
    //remove the duplicates from the index array
    for element in indexArray {
        
        if uniqueArray.contains(where: {$0 == element}) {
            
        } else {
            //if does not contain
            uniqueArray.append(element)
        }
        
        
    }//end for
    
    
    print(boardCopy)
    print(uniqueArray)
    
    //determine how many steps are needed
    let characters = steps(sequence: uniqueArray)
    
    if(word == characters) {
        exists = true
    }
    else{
        exists = false
    }
    
    print(exists)
    return exists
    
}//end func




exists(board: myBoard, word: "SEE")







