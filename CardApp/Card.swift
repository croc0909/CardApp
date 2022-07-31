//
//  Card.swift
//  CardApp
//
//  Created by AndyLin on 2022/7/30.
//

import UIKit

struct Card{
    var cardName:String?
    var cardImage:UIImage?
    var isflipped:Bool? = false
}

var Cards = [
Card(cardName: "apple",cardImage: UIImage(named: "apple")),
Card(cardName: "cherry",cardImage: UIImage(named: "cherry")),
Card(cardName: "strawberry",cardImage: UIImage(named: "strawberry")),
Card(cardName: "lemon",cardImage: UIImage(named: "lemon")),
Card(cardName: "pineapple",cardImage: UIImage(named: "pineapple")),
Card(cardName: "grape",cardImage: UIImage(named: "grape")),

Card(cardName: "apple",cardImage: UIImage(named: "apple")),
Card(cardName: "cherry",cardImage: UIImage(named: "cherry")),
Card(cardName: "strawberry",cardImage: UIImage(named: "strawberry")),
Card(cardName: "lemon",cardImage: UIImage(named: "lemon")),
Card(cardName: "pineapple",cardImage: UIImage(named: "pineapple")),
Card(cardName: "grape",cardImage: UIImage(named: "grape"))
]
