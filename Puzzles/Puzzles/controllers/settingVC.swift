//
//  settingVC.swift
//  Puzzles
//
//  Created by noyer altamimi on 13/06/1443 AH.
//

import UIKit
import AVFoundation
import PhotosUI



// For Add Sound To App 
class settingVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {


    @IBOutlet weak var soundImage: UIImageView!
    let SoudGif = UIImage.gifImageWithName("SoudGif")
    let DarkMoodSoudGif = UIImage.gifImageWithName("DarkMoodSoudGif")
    
    var gameSound : AVAudioPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundImage.image = SoudGif

    }
    

        @IBAction func clicked(_ sender: Any) {
    
        let pathToSound = Bundle.main.path(forResource: "fort", ofType: "m4a")
        let  url = URL(fileURLWithPath: pathToSound!)
        do
        {
            gameSound = try AVAudioPlayer(contentsOf: url)
            gameSound!.play()
            
        }
    catch
        {
        print(error)
    }
 }
}

