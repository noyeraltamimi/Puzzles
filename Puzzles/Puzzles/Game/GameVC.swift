//
//  GameVC.swift
//  Puzzles
//
//  Created by noyer altamimi on 03/05/1443 AH.
//

import UIKit
import SpriteKit


class GameVC: UIViewController {
    var row:Int = 3
    var col:Int = 3
    var count:Int = 0
    var timeauto:Timer!
    var width:CGFloat!
    var height:CGFloat!
    var imageViews:[UIImageView] = []
    
    var timer:Timer = Timer()
    var countTime:Int = 0
    var timerCounting:Bool = false
    
    
    
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createPuzzle()
        repeatAutosort()
        startStopButton.setTitleColor(UIColor.gray, for: .normal)
        
        //view.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        let actionOkay = UIAlertAction(title: "YES", style: .default, handler: { action in
            self.countTime = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        )
        alert.addAction(actionOkay)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func startStopTapped(_ sender: Any) {
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.gray, for: .normal)
        } else {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secodsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func secodsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
        return ((seconds / 3600) , ((seconds % 3600) / 60 ) , ((seconds % 3600) % 60))
    }
    func makeTimeString(hours: Int , minutes: Int , seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "0%2d", hours)
        timeString += " : "
        timeString += String(format: "0%2d", minutes)
        timeString += " : "
        timeString += String(format: "0%2d", seconds)
        return timeString
    }
    
    func repeatAutosort(){
        timeauto = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(autosort) , userInfo: nil, repeats: true)
    }
    
    @objc func autosort(){
        count += 1
        if count >= 50{
            timeauto.invalidate()
        }
        
        let move = width/CGFloat(col)
        var imageViewsTam = imageViews
        while imageViewsTam.count > 0 {
            let random = Int.random(in: 0...imageViewsTam.count - 1)
            let image = imageViewsTam[random]
            let x: CGFloat = image.frame.origin.x
            let y: CGFloat = image.frame.origin.y
        //    let image = imageViewsTam[random]
            if checkMove(pos: CGPoint(x: x - move, y: y)){
                UIView.animate(withDuration: 0.2) {
                    image.frame.origin.x -= move
                }
                return
            }
            
            if checkMove(pos: CGPoint(x: x + move, y: y)){
                UIView.animate(withDuration: 0.2) {
                    image.frame.origin.x += move
                }
                return
                
            }
            
            
            if checkMove(pos: CGPoint(x: x, y: y + move)){
                UIView.animate(withDuration: 0.2) {
                    image.frame.origin.x += move
                }
                
                return
                
            }
            
            
            if checkMove(pos: CGPoint(x: x, y: y + move)){
                UIView.animate(withDuration: 0.2) {
                    image.frame.origin.x -= move
                }
                
                return
                
            }
            
            imageViewsTam.remove(at: random)
        }
    }
    
    
    func createPuzzle(){
        var count:Int = 0
        
        let image = UIImage(named: "Image-1")!.resizeImage(imagesize: self.view.frame.width, row: CGFloat(row), col: CGFloat(col))
        width = image.size.width
        height = image.size.height
        let y = self.view.frame.height/2 - height/2
        //let y : CGFloat = 200.0
        let imageConvert = image.cgImage
        let sizeImage = width/CGFloat(col)
        for i in 0...row - 1{
            for j in 0...col - 1{
                let cropImage = imageConvert!.cropping(to: CGRect(x: CGFloat(j)*sizeImage, y: CGFloat(i)*sizeImage, width: sizeImage, height: sizeImage))
                let imageView = UIImageView(image: UIImage(cgImage: cropImage!))
                imageView.layer.borderWidth = 0.5
                imageView.layer.borderColor = UIColor.black.cgColor
                imageView.frame.origin = CGPoint(x: CGFloat(j)*sizeImage, y: CGFloat(i)*sizeImage + y)
                view.addSubview(imageView)
                imageView.tag = count
                count += 1
                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapimage(gesture:))))
                imageView.isUserInteractionEnabled = true
                imageViews.append(imageView)
            }
        }
        
        
        //view.subviews.last?.removeFromSuperview()
        imageViews.last?.removeFromSuperview()
        imageViews.removeLast()
    }
    
    @objc func tapimage(gesture: UITapGestureRecognizer){
        let image = gesture.view as! UIImageView
        
        let x = image.frame.origin.x
        let y = image.frame.origin.y
        let move = width/CGFloat(col)
        print(image.tag)
        print(checkOut(pos: CGPoint(x: x, y: y - move)))
        if checkMove(pos: CGPoint(x: x - move, y: y)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.x -= move
            }
            return
        }
        if checkMove(pos: CGPoint(x: x + move, y: y)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.x += move
            }
            
            return
        }
        
        
        if checkMove(pos: CGPoint(x: x, y: y + move)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.y += move
            }
            
            return
            
        }
        
        
        if checkMove(pos: CGPoint(x: x, y: y - move)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.y -= move
            }
            
            return
            
        }
        
    }
    
    func checkMove(pos:CGPoint) -> Bool{
        var count:[UIImageView] = []
        //count = imageViews.filter {$0.frame.origin == pos}
        count = imageViews.filter {$0.frame.origin.x - pos.x > -1 && $0.frame.origin.x - pos.x < 1 && $0.frame.origin.y - pos.y > -1  &&   $0.frame.origin.y - pos.y < 1}
        if count == [] && checkOut(pos: pos){
            return true
        }
        return false
    }
    
    func checkOut(pos:CGPoint) -> Bool{
        let top: CGFloat = self.view.frame.height/2 - height/2 - 1
        //let top:CGFloat =   200.0
        let left:CGFloat = -1
        let right:CGFloat = width - width/CGFloat(col) + 1
        let bottom:CGFloat = self.view.frame.height/2 + height/2 - width/CGFloat(col) + 1
        if pos.x < left || pos.x > right || pos.y < top || pos.y > bottom{
            return false
        }
        return true
    }
    
}

extension UIImage{
    func resizeImage(imagesize:CGFloat,row:CGFloat,col:CGFloat) -> UIImage{
        let newSize = CGSize(width: imagesize, height: imagesize + (row - col)*imagesize/col)
        let rect = CGRect(x: 0, y:0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


