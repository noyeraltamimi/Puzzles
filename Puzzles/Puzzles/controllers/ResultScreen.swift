//
//  ResultScreen.swift
//  Puzzles
//
//  Created by noyer altamimi on 09/05/1443 AH.
//

import Foundation
import UIKit
import CoreData

class ResultScreen: UIViewController , UISearchBarDelegate {

    var players : [Player] = []
    
    var name : String = ""
    var time : Int = 0

    @IBOutlet weak var resultBackgrund: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    let puzzleGIF = UIImage.gifImageWithName("puzzleGIF")
    let DarkPuzzleGif = UIImage.gifImageWithName("DarkPuzzleGif")
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if traitCollection.userInterfaceStyle == .light {
        print("Light mode")
    } else {
        print("Dark mode")
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultBackgrund.image = puzzleGIF
        scoreLabel.text = "Good Job you are Win".Localized
        

}
    
}
