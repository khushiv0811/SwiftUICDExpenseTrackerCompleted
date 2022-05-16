//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    @State var iseuro : Bool = false
    ///Set button text here
    @State private var buttontext: String = "$"
    /// rate for eur to dollar
    @State var rate : Double = 1.0
    
    var body: some View {
        NavigationView {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                if totalExpenses != nil {
                    Text("Total expenses")
                        .font(.headline)
                    if totalExpenses != nil {
                        if iseuro == true{
                        Text(totalExpenses!.formattedCurrencyTextineuro)
                            .font(.largeTitle)}
                        else {Text(totalExpenses!.formattedCurrencyText)
                            .font(.largeTitle)}
                    }
                }
            }
            
            if categoriesSum != nil {
                if totalExpenses != nil && totalExpenses! > 0 {
                    PieChartView(
                        data: categoriesSum!.map { ($0.sum, $0.category.color) },
                        style: Styles.pieChartStyleOne,
                        form: CGSize(width: 300, height: 240),
                        dropShadow: false
                    )
                }
                
                Divider()

                List {
                    Text("Breakdown").font(.headline)
                    ForEach(self.categoriesSum!) {
                        CategoryRowView(category: $0.category, sum: $0.sum, iseuro: iseuro)
                    }
                }
            }
            
            if totalExpenses == nil && categoriesSum == nil {
                Text("No expenses data\nPlease add your expenses from the logs tab")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(.horizontal)
            }
        }
        .padding(.top)
        .onAppear(perform: fetchTotalSums)
        .navigationBarItems(trailing: Button(action: euroTapped) { Text(buttontext) })
        .navigationBarTitle("Dashboard", displayMode: .inline)
        
    }
    
    
    
}
        //MARK: Button Euro Tapped
     func euroTapped()
    {
        /// If selected currency is dollar
        if (self.buttontext == "$"){
            ///change the currency to euro
            self.buttontext = "€"
            iseuro = true
            let cr = Currenyrequest(amount: 0, to_currency: "EUR", from_currency: "USD")
            ///API for currency
             postjsonapi(currencyrequest: cr, completion: { (_ reponse : CurrenyResponseModel,  _ success: Bool) -> Void in
                 if success
                 {
                     let crm = reponse
                     rate = crm.rate
                     self.fetchTotalSums()
                }
                 })
        }
        else
        {
            ///If selection is euro , on tap change to $
            self.buttontext = "$"
            iseuro = false
            rate = 1
            fetchTotalSums()
        }
      
        
        
    }
    func fetchTotalSums() {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum * rate
            self.categoriesSum = results.map({ (result) -> CategorySum in
                let categorysum = result.sum * rate
                return CategorySum(sum: categorysum, category: result.category, iseuro: iseuro)
            })
        }
    }
}

struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    let iseuro : Bool
    
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
