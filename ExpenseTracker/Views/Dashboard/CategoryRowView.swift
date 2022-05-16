//
//  CategoryRowView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CategoryRowView: View {
    let category: Category
    let sum: Double
    let iseuro : Bool
    
    
    var body: some View {
        HStack {
            CategoryImageView(category: category)
            Text(category.rawValue.capitalized)
            Spacer()
            if iseuro == false {
                Text(sum.formattedCurrencyText).font(.headline)}
            else {Text(sum.formattedCurrencyTextineuro).font(.headline)}
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: .donation, sum: 2500 , iseuro :false )
    }
}
