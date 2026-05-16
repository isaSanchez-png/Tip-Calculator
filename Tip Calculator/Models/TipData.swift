//
//  TipData.swift
//  Tip Calculator
//
//  Created by Isa on 16/05/26.
//

import SwiftUI

struct TipData {
    var total: Double
    var tipPercentage: Int
    var numberOfPeople: Int
    
    var usePercentageCustom = false
    var percentageCustom: Int
    
    
    var totalIncludingTip: Double {
        return total + tipAmount
    }
    
    var tipPerPerson: Double {
        return totalIncludingTip / Double(numberOfPeople)
    }
    
    var actualPercentage: Int {
        usePercentageCustom ? percentageCustom : tipPercentage
    }
    
    var tipAmount: Double {
            return total * Double(actualPercentage) / 100
        }
}
