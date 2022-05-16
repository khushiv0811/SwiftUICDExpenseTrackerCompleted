//
//  FiltermonthsView.swift
//  ExpenseTracker
//
//  Created by Kushboo Patel on 5/13/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FiltermonthsView: View {
    
    @Binding var selectedMonths: Set<Months>
    private let _Months = Months.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(_Months) { Month in
                    FilterMonthButtonView(
                        Months: Month,
                        isSelected: self.selectedMonths.contains(Month),
                        onTap: self.onTap
                    )
                        
                       .padding(.leading, Month == self._Months.first ? 16 : 0)
                      .padding(.trailing, Month == self._Months.last ? 16 : 0)
                    
                }
            }
        }
        .padding(.vertical)
    }
    
    func onTap(Months: Months) {
        if selectedMonths.contains(Months) {
            selectedMonths.remove(Months)
        } else {
            selectedMonths.insert(Months)
        }
    }
}

struct FilterMonthButtonView: View {
    
    var Months: Months
    var isSelected: Bool
    var onTap: (Months) -> ()
    
    var body: some View {
        Button(action: {
            self.onTap(self.Months)
        }) {
            HStack(spacing: 8) {
                Text(Months.rawValue.capitalized)
                    .fixedSize(horizontal: true, vertical: true)
                
                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
                
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Months.color : Color(UIColor.lightGray), lineWidth: 1))
                .frame(height: 44)
        }
        .foregroundColor(isSelected ? Months.color : Color(UIColor.gray))
    }
    
    
}

struct FiltermonthsView_Previews: PreviewProvider {
    static var previews: some View {
        FiltermonthsView(selectedMonths: .constant(Set()))
    }
}
