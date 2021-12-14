//
//  ResultScreen.swift
//  Puzzles
//
//  Created by noyer altamimi on 09/05/1443 AH.
//

import Foundation
import UIKit

class ResultScreen: UIViewController {


    @IBOutlet weak var scoreLabel: UILabel!
    
    var totalPoints : Int!

    override func viewDidLoad() {
        super.viewDidLoad()

    scoreLabel.text = "\(totalPoints ?? 0)"

}
    
}
