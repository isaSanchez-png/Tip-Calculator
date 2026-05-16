//
//  TipManager.swift
//  Tip Calculator
//
//  Created by Isa on 16/05/26.
//

import SwiftUI
import Combine // Required for ObservableObject in newer Swift versions

class TipManager: ObservableObject {
    @Published var tipData = TipData (total: 0, tipPercentage: 10, numberOfPeople: 1, usePercentageCustom: false, percentageCustom: 0)
    
    var tipPercentageCustom = false

    
    func updateTotal (_newTotal: Double){
        tipData.total = _newTotal
    }
    
    func updateTipPercentage (_newTipPercentage: Int){
        tipData.tipPercentage = _newTipPercentage
    }
    
    func updateNumberOfPeople (_newNumberOfPeople: Int){
        tipData.numberOfPeople = _newNumberOfPeople
    }
    
    func selectCustomTip(_ valor: Int) {
        tipData.tipPercentage = valor
        tipData.usePercentageCustom = false
    }
    
    func activeCustomMode() {
        tipData.usePercentageCustom = true
        if tipData.percentageCustom == 0 {
            tipData.percentageCustom = tipData.tipPercentage
        }
    }
    
    func updateCustomTipPercentage(_ valor: Int) {
        tipData.percentageCustom = max(0, min(100, valor))
    }
}

