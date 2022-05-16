//
//  API.swift
//  ExpenseTracker
//
//  Created by Kushboo Patel on 5/16/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation

struct CurrenyResponseModel: Codable {
    var amount: Double
    var rate: Double
  //  var completed: Bool
    
}
struct Currenyrequest: Codable {
    var amount: Float
    var to_currency: String
    var from_currency: String
   // var completed: Bool
    
}


   func postjsonapi(currencyrequest : Currenyrequest , completion:@escaping (_ response : CurrenyResponseModel ,  _ success: Bool) -> Void)
    {
        let url = URL(string: "https://elementsofdesign.api.stdlib.com/aavia-currency-converter@dev/")
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        // Set HTTP Request Header
       // request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      //  let currencyresponse = CurrenyResponseModel(amount: 0.0, rate: 0.0 , completed: true)
        
        let jsonData = try! JSONEncoder().encode(currencyrequest)

        request.httpBody = jsonData
        
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                guard let data = data else {return}

               
                do{
                   
                    let todoItemModel = try JSONDecoder().decode(CurrenyResponseModel.self, from: data)
                    print("Response data:\n \(todoItemModel)")
                    completion(todoItemModel , true)
                    
                }
                catch let jsonErr{
                    print(jsonErr)
                    let response = CurrenyResponseModel(amount: 0, rate: 0)
                    completion(response , false)
               }

         
        }
        task.resume()
    }



