//
//  MonthsTabView.swift
//  ExpenseTracker
//
//  Created by Kushboo Patel on 5/13/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct MonthsTabView: View {
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedmonths: Set<Months> = Set()
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Divider()
                FiltermonthsView(selectedMonths: $selectedmonths)
                
                Divider()
                LogListView(predicate: ExpenseLog.predicate(with: Array(selectedCategories), with: Array(selectedmonths), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
            }
            .padding(.bottom, searchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                LogFormView(context: self.context)
            }
           
            .navigationBarTitle("Monthly Summary", displayMode: .inline)
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
}

struct MonthsTabView_Previews: PreviewProvider {
    static var previews: some View {
        MonthsTabView()
    }
}
