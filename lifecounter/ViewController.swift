//
//  ViewController.swift
//  lifecounter
//
//  Created by Lei Ryan on 4/23/21.
//

import UIKit

class ViewController: UIViewController {

    var lifeOne : Int = 0
    var lifeTwo : Int = 0
    var lifeThree : Int = 0
    var lifeFour : Int = 0
    

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var playerOne: UILabel!
    @IBOutlet weak var playerTwo: UILabel!
    @IBOutlet weak var playerThree: UILabel!
    @IBOutlet weak var playerFour: UILabel!
    
    
    @IBOutlet weak var result: UILabel!
    
    
    @IBAction func one(_ sender: UIButton) {
        switch sender.currentTitle {
            case "+":
                lifeOne += 1
                playerOne.text = "Player One: \(lifeOne)"
            case "-":
                lifeOne -= 1
                playerOne.text = "Player One: \(lifeOne)"
                if lifeOne <= 0 {
                    result.text = "Player One LOSES!"
                }
            case "+5":
                lifeOne += 5
                playerOne.text = "Player One: \(lifeOne)"
            case "-5":
                lifeOne -= 5
                playerOne.text = "Player One: \(lifeOne)"
                if lifeOne <= 0 {
                    result.text = "Player One LOSES!"
                }
            default:
                break
            }
    }
    
    @IBAction func two(_ sender: UIButton) {
        switch sender.currentTitle {
            case "+":
                lifeTwo += 1
                playerTwo.text = "Player One: \(lifeTwo)"
            case "-":
                lifeTwo -= 1
                playerTwo.text = "Player One: \(lifeTwo)"
                if lifeTwo <= 0 {
                    result.text = "Player Two LOSES!"
                }
            case "+5":
                lifeTwo += 5
                playerTwo.text = "Player One: \(lifeTwo)"
            case "-5":
                lifeTwo -= 5
                playerTwo.text = "Player One: \(lifeTwo)"
                if lifeTwo <= 0 {
                    result.text = "Player Two LOSES!"
                }
            default:
                break
            }
    }
    
    @IBAction func three(_ sender: UIButton) {
        switch sender.currentTitle {
            case "+":
                lifeThree += 1
                playerThree.text = "Player One: \(lifeThree)"
            case "-":
                lifeThree -= 1
                playerThree.text = "Player One: \(lifeThree)"
                if lifeThree <= 0 {
                    result.text = "Player Three LOSES!"
                }
            case "+5":
                lifeThree += 5
                playerThree.text = "Player One: \(lifeThree)"
            case "-5":
                lifeThree -= 5
                playerThree.text = "Player One: \(lifeThree)"
                if lifeThree <= 0 {
                    result.text = "Player Three LOSES!"
                }
            default:
                break
            }
    }
    
    @IBAction func four(_ sender: UIButton) {
        switch sender.currentTitle {
            case "+":
                lifeFour += 1
                playerFour.text = "Player One: \(lifeFour)"
            case "-":
                lifeFour -= 1
                playerFour.text = "Player One: \(lifeFour)"
                if lifeFour <= 0 {
                    result.text = "Player Four LOSES!"
                }
            case "+5":
                lifeFour += 5
                playerFour.text = "Player One: \(lifeFour)"
            case "-5":
                lifeFour -= 5
                playerFour.text = "Player One: \(lifeFour)"
                if lifeFour <= 0 {
                    result.text = "Player Four LOSES!"
                }
            default:
                break
            }
    }
    
    override func viewDidLoad() {
        playerOne.adjustsFontSizeToFitWidth = true
        playerOne.minimumScaleFactor = 0.5
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //buttonOne.addTarget(self, action: #selector(ViewController.plus(_:)), for: UIControl.Event.touchUpInside)
        //buttonTwo.addTarget(self, action: #selector(ViewController.plus(_:)), for: UIControl.Event.touchUpInside)
        //buttonThree.addTarget(self, action: #selector(ViewController.plus(_:)), for: UIControl.Event.touchUpInside)
        //buttonFour.addTarget(self, action: #selector(ViewController.plus(_:)), for: UIControl.Event.touchUpInside)
        
    }


}

