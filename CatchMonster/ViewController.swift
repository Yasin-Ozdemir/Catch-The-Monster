//
//  ViewController.swift
//  CatchMonster
//
//  Created by Yasin Özdemir on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var TimeLbel: UILabel!
    
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    
    @IBOutlet weak var BestScoreLabel: UILabel!
    
    
    @IBOutlet weak var monster1: UIImageView!
    
    @IBOutlet weak var monster2: UIImageView!
    @IBOutlet weak var monster3: UIImageView!
    @IBOutlet weak var monster4: UIImageView!
    @IBOutlet weak var monster5: UIImageView!
    @IBOutlet weak var monster6: UIImageView!
    @IBOutlet weak var monster7: UIImageView!
    @IBOutlet weak var monster8: UIImageView!
    @IBOutlet weak var monster9: UIImageView!
    
    var timer = Timer()
    var count = 10
    var score = 0
    var bestscore = 0
    var monsterArray = [UIImageView]()
    
    var timer2 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreLabel.text = "Score: \(score)"
        
        var storedbestscore = UserDefaults.standard.object(forKey: "bestscore")
        if storedbestscore == nil{
            bestscore = 0
            BestScoreLabel.text = "Best Score: \(bestscore)"
        }
        else{
            bestscore = storedbestscore as! Int
            BestScoreLabel.text = "Best Score: \(bestscore)"
        }
        monsterArray = [monster1 , monster2, monster3,monster4,monster5,monster6,monster7,monster8,monster9]
        
        monster1.isUserInteractionEnabled = true
         monster2.isUserInteractionEnabled = true
         monster3.isUserInteractionEnabled = true
         monster4.isUserInteractionEnabled = true
         monster5.isUserInteractionEnabled = true
         monster6.isUserInteractionEnabled = true
         monster7.isUserInteractionEnabled = true
         monster8.isUserInteractionEnabled = true
         monster9.isUserInteractionEnabled = true
         
         var gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(Score))
         var gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(Score))
         
         monster1.addGestureRecognizer(gestureRecognizer1)
         monster2.addGestureRecognizer(gestureRecognizer2)
         monster3.addGestureRecognizer(gestureRecognizer3)
         monster4.addGestureRecognizer(gestureRecognizer4)
         monster5.addGestureRecognizer(gestureRecognizer5)
         monster6.addGestureRecognizer(gestureRecognizer6)
         monster7.addGestureRecognizer(gestureRecognizer7)
         monster8.addGestureRecognizer(gestureRecognizer8)
         monster9.addGestureRecognizer(gestureRecognizer9)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerr), userInfo: nil, repeats: true)
        
      
        
        timer2 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(runningMonster), userInfo: nil, repeats: true)
        
        
        
        
        
}
    
    
    @objc func  runningMonster (){
        for monster in monsterArray{
            monster.isHidden = true
        }
        var random =  Int(arc4random_uniform(UInt32(9)))
        monsterArray[random].isHidden = false
    }
    
    
    @objc func Score (){
        score += 1
        ScoreLabel.text = "Score: \(score)"
        
    }
    
    
    
    @objc func timerr (){
        TimeLbel.text = "Time : \(count)"
        count -= 1
        if count == 0{
            TimeLbel.text = "Time Over"
            timer.invalidate()
            timer2.invalidate()
            for monster in monsterArray{
                monster.isHidden = true
            }
            if self.bestscore < score {
                self.bestscore = score
                BestScoreLabel.text = "Best Score: \(self.bestscore)"
                UserDefaults.standard.set(self.bestscore, forKey: "bestscore")
            }
            var alert = UIAlertController(title: "Time Over!", message: "Do you want replay?", preferredStyle: UIAlertController.Style.alert)
            var ReplayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){_ in
                self.score = 0
                self.ScoreLabel.text = "Score : \(self.score)"
                self.count = 10
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerr), userInfo: nil, repeats: true)
                self.timer2 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.runningMonster), userInfo: nil, repeats: true)
            }
            var CancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
            alert.addAction(ReplayButton)
            alert.addAction(CancelButton)
            self.present(alert, animated: true)
            
        }
    }
}

