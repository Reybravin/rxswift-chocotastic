//
//  String+CreditCard.swift
//  Chocotastic
//
//  Created by Ellen Shapiro on 6/7/16.
//  Copyright © 2016 RayWenderlich.com. All rights reserved.
//

import Foundation

extension String {
  
  func rw_allCharactersAreNumbers() -> Bool {
    let nonNumberCharacterSet = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    return (self.rangeOfCharacterFromSet(nonNumberCharacterSet) == nil)
  }
  
  
  func rw_integerValueOfFirstCharacters(characterCount: Int) -> Int {
    guard rw_allCharactersAreNumbers() else {
      return NSNotFound
    }
    
    if characterCount > self.characters.count {
      return NSNotFound
    }
    
    let indexToStopAt = self.startIndex.advancedBy(characterCount)
    let substring = self.substringToIndex(indexToStopAt)
    guard let integerValue = Int(substring) else {
      return NSNotFound
    }
    
    return integerValue
  }
  
  
  func rw_isLuhnValid() -> Bool {
    //https://www.rosettacode.org/wiki/Luhn_test_of_credit_card_numbers
    
    guard self.rw_allCharactersAreNumbers() else {
      //Definitely not valid.
      return false
    }
    
    let reversed = self.characters.reverse().map { String($0) }
    
    var sum = 0
    for (index, element) in reversed.enumerate() {
      guard let digit = Int(element) else {
        //This is not a number.
        return false
      }
      
      if index % 2 == 1 {
        //Even digit
        switch digit {
        case 9:
          //Just add nine.
          sum += 9
        default:
          //Multiply by 2, then take the remainder when divided by 9 to get addition of digits.
          sum += ((digit * 2) % 9)
        }
      } else {
        //Odd digit
        sum += digit
      }
    }
    
    //Valid if divisible by 10
    return sum % 10 == 0
  }
  
  func rw_removeSpaces() -> String {
    return self.stringByReplacingOccurrencesOfString(" ", withString: "")
  }
}
