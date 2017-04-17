//
//  ViewController.swift
//  algorithmFun
//
//  Created by Ehsan Zaman on 4/14/17.
//  Copyright © 2017 Ehsan Zaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var charLabel: UILabel!
    var wordSet = [String]()
    var newWord = ""
    var maxchar = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
     tableView.layer.cornerRadius = 6
     tableView.isHidden = true
     charLabel.isHidden = true
        
    }

    
//button converting textfield entry into permutations
    @IBAction func convert(_ sender: Any) {
        newWord = textfield.text!
        let arrayofstring = newWord.characters.map { String($0) }
        permute(list: arrayofstring)
        returnMostCommonCharacter(string: newWord)
        
        tableView.isHidden = false
        charLabel.isHidden = false
        tableView.reloadData()
        charLabel.text = maxchar
    }
    
//algorithm returning most common character in a string
    
    func returnMostCommonCharacter(string: String) -> Character {
        var characters = Array(string.characters)
        var dict = Dictionary<Character, Int>()
        var maxCharacter = characters[0]
        var maxCount = 0
        
        for character in characters {
            if let seenCharCount = dict[character] {
                dict[character] = seenCharCount + 1
                
                if dict[character]! > maxCount {
                    maxCharacter = character
                    maxCount = dict[character]!
                    
                }
                
            } else {
                dict[character] = 1
            }
        }
        maxchar = String(maxCharacter)
        return maxCharacter
    }
   
// permutation of textfield word entry
    
func permute(list: [String], minStringLen: Int = 1) -> Set<String> {
    
        func permute(fromList: [String], toList: [String], minStringLen: Int, set: inout Set<String>) {
            if toList.count >= minStringLen {
                set.insert(toList.joined(separator: ""))
            }
            if !fromList.isEmpty {
                for (index, item) in fromList.enumerated() {
                    var newFrom = fromList
                    newFrom.remove(at: index)
                    permute(fromList: newFrom, toList: toList + [item], minStringLen: minStringLen, set: &set)
                }
            }
        }
        
        var set = Set<String>()
        permute(fromList: list, toList:[], minStringLen: minStringLen, set: &set)
    
        wordSet = Array(set)
        wordSet.sort {$0 < $1 }
        print(wordSet)
        return set
    }

    
    
//tableview set up
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordSet.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = wordSet[indexPath.row]
        
        return cell
    }
    
  
  
    
    
}

