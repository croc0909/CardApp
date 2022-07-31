//
//  ViewController.swift
//  CardApp
//
//  Created by AndyLin on 2022/7/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var scoreView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons:[UIButton]!
    
    //計時器
    var time:Timer?
    //卡片資料
    var cards = [Card]()
    //翻卡數量
    var pickedCard = [Int]()
    //得分
    var score = 0
    
    // 遊戲開始前倒數
    var seeTime = 3
    //遊戲時間
    var gameTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInit()
        // Do any additional setup after loading the view.
    }


    func gameInit()
    {
        //設定顯示時間、分數、圓角
        timeLabel.text = String(seeTime)
        scoreLabel.text = String(score)
        timeView.layer.cornerRadius = 20
        scoreView.layer.cornerRadius = 20
        //讀取卡片資料
        cards = Cards
        //將陣列內容重新排序
        cards.shuffle()
        //初始化卡片
        self.displayCards()
    }
    
    func displayCards()
    {
        //設定每張牌的圖片
        for (i,_) in cards.enumerated(){
            cardButtons[i].setImage(cards[i].cardImage, for: .normal)
            cards[i].isflipped = true
            //設定圓角
            cardButtons[i].imageView?.clipsToBounds = true
            cardButtons[i].layer.cornerRadius = 20
        }
        //
        if time == nil {
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        }
    }
    
    @objc func countDown() {
        //遊戲開始時間倒數
        seeTime -= 1
        if seeTime == 0 {
            //停止計時器並把time設為nil
            time?.invalidate()
            time = nil
            
            for (i,_) in cards.enumerated() {
                cardButtons[i].setImage(UIImage(named: "cardback"), for: .normal)
                //使用 UIView 的翻牌效果
                UIView.transition(with: cardButtons[i], duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
                cards[i].isflipped = false
            }
            
            //使用DispatchQueue設定：翻牌後三秒執行timeView翻轉及開始gameTime倒數
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                // 讓timeView 也做一次翻轉效果
                UIView.transition(with: self.timeView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                // 將 timeLabel 變換為遊戲倒數時間
                self.timeLabel.text = String(self.gameTime)
                // 設定新的計時器 開始倒數
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.gameTimeCountDown), userInfo: nil, repeats: true)
                
            }
        }
        timeLabel.text = String(seeTime)
    }
    
    @objc func gameTimeCountDown() {
        // 遊戲時間倒數
        gameTime -= 1
        // 設定時間給 label 顯示
        timeLabel.text = String(gameTime)
        // 遊戲時間到
        if gameTime == 0 {
            time?.invalidate()
            time = nil
            //使用 UIAlertController 跳出提示視窗
            let timeOutAlert = UIAlertController(title: "遊戲時間到 !!", message: "再試一次吧", preferredStyle: .alert)
            let timeOutAction = UIAlertAction(title: "Restart", style: .default) { (_) in
                self.restart()
            }
            timeOutAlert.addAction(timeOutAction)
            present(timeOutAlert, animated: true, completion: nil)
        }
    }
    
    func restart() {
        seeTime = 3
        gameTime = 60
        score = 0
        pickedCard.removeAll()
        
        for i in cardButtons{
            i.isEnabled = true
        }
        gameInit()
    }
    
    @IBAction func flipCardAction(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            pickedCard.append(cardNumber)
            flip(index: cardNumber)
            print(pickedCard)
            print(pickedCard.count)
            
            //當選取兩張牌的時候，判斷兩卡牌是否相同
            if pickedCard.count == 2 {
                if cards[pickedCard[0]].cardName == cards[pickedCard[1]].cardName {
                    print("相同")
                    //0.6秒後執行: score+1, enabled=false並翻牌
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        self.score += 1
                        self.scoreLabel.text = String(self.score)
                        for i in self.pickedCard{
                            self.cardButtons[i].isEnabled = false
                            UIView.transition(with: self.cardButtons[i], duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                        }
                        //如果全部猜完，跳出alert: GameComplete。
                        if self.score == 6 {
                            self.time?.invalidate() //時間暫停，否則時間將在背後持續運行。
                            self.time = nil
                            let gameCompleteAlert = UIAlertController(title: "勝利 !", message: "恭喜過關 !", preferredStyle: .alert)
                            let gameCompleteAction = UIAlertAction(title: "Restart", style: .default) { (_) in
                                self.restart()
                            }
                            gameCompleteAlert.addAction(gameCompleteAction)
                            self.present(gameCompleteAlert, animated: true, completion: nil)
                        }
                        //pickedCard內容清除
                        self.pickedCard.removeAll()
                    }
                //如兩組牌不相同：牌翻回背面
                }else{
                    print("不同")
                    //0.6秒後執行翻牌回背面
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        for i in self.pickedCard {
                            flip(index: i)
                        }
                        //pickedCard內容清除
                        self.pickedCard.removeAll()
                    }
                }
            }
        }
        
        //判斷卡牌要翻正、反面，正面時，翻背面/背面時，翻正面
        func flip(index:Int) {
            if cards[index].isflipped == false {
                cardButtons[index].setImage(cards[index].cardImage, for: .normal)
                UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                cards[index].isflipped = true
            }else{
                cardButtons[index].setImage(UIImage(named: "cardback"), for: .normal)
                UIView.transition(with: cardButtons[index], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
                cards[index].isflipped = false
            }
        }
    }
}

