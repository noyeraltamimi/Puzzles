//
//  ArabicVC.swift
//  Puzzles
//
//  Created by noyer altamimi on 10/06/1443 AH.
//

import UIKit

class ArabicVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension String {
    var Localized: String {
        return NSLocalizedString(self, comment: "" )
    }
}
