//
//  ViewController.swift
//  Puzzles
//
//  Created by noyer altamimi on 02/05/1443 AH.
//

import UIKit
import FirebaseAuth
import PhotosUI



class ViewController: UIViewController {
      
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
  
    @IBOutlet weak var background: UIImageView!
    
    let puzzleGIF = UIImage.gifImageWithName("puzzleGIF")

    
    override func viewDidLoad() {
        super.viewDidLoad()
    background.image = puzzleGIF

    }
        
        
    @IBAction func userlogin(_ sender: Any) {
   

    Auth.auth().signIn(withEmail: userEmail.text ?? "", password: userPassword.text ?? "") { user, error in
        if let error = error {
            
          self.showAlart(titale: "Error", masge: "error is \(error.localizedDescription)")
        }else{
          self.performSegue(withIdentifier: "HomeVC", sender: nil)
        }
      }
    }
    func showAlart(titale : String , masge : String) {
      let alart = UIAlertController(title: titale, message: masge, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".Localized, style: .default, handler: nil)
      alart.addAction(ok)
      present(alart, animated: true, completion: nil)
 
}
}

