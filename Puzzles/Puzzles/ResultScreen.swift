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

    
    @IBOutlet weak var scoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       scoreLabel.text = "Congratulations \(name) , you are finish in \(time) "
        

}
    
}
