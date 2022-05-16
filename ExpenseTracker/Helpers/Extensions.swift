//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

extension Double {
    
    var formattedCurrencyText: String {
        return Utils.numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    var formattedCurrencyTextineuro: String {
        return Utils.euronumberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}

func getmonth(_ date : Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    
   
        let month = dateFormatter.string(from: date)
        
        return month
    
   
}
