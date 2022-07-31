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
Card(cardName: "banana",cardImage: UIImage(named: "banana")),
Card(cardName: "tangerine",cardImage: UIImage(named: "tangerine")),
Card(cardName: "watermelon",cardImage: UIImage(named: "watermelon")),

Card(cardName: "apple",cardImage: UIImage(named: "apple")),
Card(cardName: "cherry",cardImage: UIImage(named: "cherry")),
Card(cardName: "strawberry",cardImage: UIImage(named: "strawberry")),
Card(cardName: "banana",cardImage: UIImage(named: "banana")),
Card(cardName: "tangerine",cardImage: UIImage(named: "tangerine")),
Card(cardName: "watermelon",cardImage: UIImage(named: "watermelon"))
]
