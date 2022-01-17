//
//  GameVC.swift
//  Puzzles
//
//  Created by noyer altamimi on 03/05/1443 AH.
//

import UIKit
import CoreData


class GameVC: UIViewController {
   
    // for game
    var row:Int = 3
    var col:Int = 3
    var count:Int = 0
    var timeauto:Timer!
    var width:CGFloat!
    var height:CGFloat!
    var imageViews:[UIImageView] = []
    var showImage:[Gallery] = []
    var selctedimage : UIImage!
    //for Timer
    var timer:Timer = Timer()
    var countTime:Int = 0
    var timerCounting:Bool = false
    
    var correctOrder : [CGPoint] = []

    
    
    
    @IBOutlet weak var TimerLabel: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createPuzzle()
        getCorrectOrder()
        repeatAutosort()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        
    }
    
    
    func getCorrectOrder(){
        for nImage in imageViews {
            correctOrder.append(nImage.frame.origin)
        }
        
        
    }
    
    func checkIfCorrect(){
        var newOrder : [CGPoint] = []
        
        for nImage in imageViews {
            newOrder.append(nImage.frame.origin)
        }
        
        for i in 0...newOrder.count - 1 {
            if !(newOrder[i].x == correctOrder[i].x && newOrder[i].y == correctOrder[i].y) {
                print("wrong order")
                return
            }
            
        }
        
        print("corret!")
        //to do
        showCorrect()
        
}
    
    
    
    func showCorrect() {
        timerCounting = false
        timer.invalidate()
//        let alert = UIAlertController(title: " Are You Finish ? ", message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
//        present(alert, animated: true, completion: nil)
        performSegue(withIdentifier: "moveToResult", sender: nil)
        
        
    }
    

    @IBAction func startStopTapped(_ sender: Any) {
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        } else {
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    

    @objc func timerCounter() -> Void {
        countTime = countTime + 1
        let time = secodsToHoursMinutesSeconds(seconds: countTime)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func secodsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
        return ((seconds / 3600) , ((seconds % 3600) / 60) , ((seconds % 3600) % 60))
    }
    func makeTimeString(hours: Int , minutes: Int , seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
        func repeatAutosort(){
        timeauto = Timer.scheduledTimer(timeInterval: 0.001 , target: self, selector: #selector(autosort) , userInfo: nil, repeats: true)
    }
    
     
    @objc func autosort(){
        count += 1
        if count >= 700 {
            timeauto.invalidate()
        }
        
        let move = width/CGFloat(col)
        var imageViewsTam = imageViews
        while imageViewsTam.count > 0 {
            let random = Int.random(in: 0...imageViewsTam.count - 1)
            let image = imageViewsTam[random]
            let x: CGFloat = image.frame.origin.x
            let y: CGFloat = image.frame.origin.y
            
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
            
            imageViewsTam.remove(at: random)
        }
    }
    
    
    func createPuzzle(){
        
        var count:Int = 0
        let gameImage = selctedimage.resizeImage(imagesize: self.view.frame.width, row: CGFloat(row), col: CGFloat(col))
        width = gameImage.size.width
        height = gameImage.size.height
        let y = self.view.frame.height/2 - height/2
        let imageConvert = gameImage.cgImage
        let sizeImage = width/CGFloat(col)

        for i in 0...row - 1{
            for j in 0...col - 1{
                let cropImage = imageConvert!.cropping(to: CGRect(x: CGFloat(j)*sizeImage, y: CGFloat(i)*sizeImage, width: sizeImage, height: sizeImage))
                let imageView = UIImageView(image: UIImage(cgImage: cropImage!))
                imageView.layer.borderWidth = 0.6
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
        
        imageViews.last?.removeFromSuperview()
        imageViews.removeLast()
        
    }
    
    @objc func tapimage(gesture: UITapGestureRecognizer){
        if !timerCounting {
            return
        }
        
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
            checkIfCorrect()
            return
        }
        if checkMove(pos: CGPoint(x: x + move, y: y)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.x += move
            }
            checkIfCorrect()
            return
        }
        
        
        if checkMove(pos: CGPoint(x: x, y: y + move)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.y += move
            }
            checkIfCorrect()
            return
        }
        
        
        if checkMove(pos: CGPoint(x: x, y: y - move)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.y -= move
            }
            checkIfCorrect()
            return
        }
        
    }
    
    func checkMove(pos:CGPoint) -> Bool{
        var count:[UIImageView] = []
        count = imageViews.filter {$0.frame.origin.x - pos.x > -1 && $0.frame.origin.x - pos.x < 1 && $0.frame.origin.y - pos.y > -1  &&   $0.frame.origin.y - pos.y < 1}
        if count == [] && checkOut(pos: pos){
            return true
        }
        return false
    }
    
    func checkOut(pos:CGPoint) -> Bool{
        let top: CGFloat = self.view.frame.height/2 - height/2 - 1
        // let top:CGFloat =   200.0
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


