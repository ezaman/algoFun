//
//  dictionaryJSON.swift
//  algorithmFun
//
//  Created by Ehsan Zaman on 4/14/17.
//  Copyright © 2017 Ehsan Zaman. All rights reserved.
//


//// TO BE UPDATED AND USED IN THE FUTURE

import Foundation

class json {
    
    static let shared = json()
    
    func getdata() -> [String] {
        let urlString = "https://raw.githubusercontent.com/adambom/dictionary/master/dictionary.json"
        let url = NSURL(string: urlString)!
        let urlSession = URLSession.shared
        var wordDict = [String: AnyObject]()
        var newArray = [String]()
        
        
        let jsonQuery = urlSession.dataTask(with: url as URL, completionHandler: { data, response, error -> Void in
            do {
                if let jsonDate = data, let jsonResult = try JSONSerialization.jsonObject(with: jsonDate, options: .allowFragments) as? NSDictionary {
                    
                    wordDict = jsonResult as! [String : AnyObject]
                    var array = wordDict.flatMap() {$0.0 as? String }
                    newArray = array.map { $0.lowercased()}
                    
                    
                    
                }
            } catch let error as NSError {
                print(error)
            }
            
        })
        jsonQuery.resume()
        
        return newArray
    }
    
    
    
    
    
    
}
