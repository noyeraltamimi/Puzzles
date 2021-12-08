//
//  GameVC.swift
//  Puzzles
//
//  Created by noyer altamimi on 03/05/1443 AH.
//

import UIKit

class GameVC: UIViewController {
    var row:Int = 4
    var col:Int = 3
    var count:Int = 0
    var timeauto:Timer!
    var width:CGFloat!
    var height:CGFloat!
    var imageView:[UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createPuzzle()
        repeatAutosort()
        
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
        var imageViewTam = imageView
        
        while imageViewTam.count > 0 {
            let random = Int.random(in: 0...imageViewTam.count - 1)
            let image = imageViewTam[random]
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
                    image.frame.origin.x -= move
                }

                return

            }

            
            if checkMove(pos: CGPoint(x: x, y: y + move)){
                UIView.animate(withDuration: 0.2) {
                    image.frame.origin.x -= move
                }
                
                return

            }
            
            
            
        }
       
        }
    

    func createPuzzle(){
        var count:Int = 0
        let image = UIImage(named: "Image1")!.resizeImage(imagesize: self.view.frame.width, row: CGFloat(row), col: CGFloat(col))
        width = image.size.width
        height = image.size.height
        let y = self.view.frame.height/2 - height/2
        let imageConvert = image.cgImage
        let sizeImage = width/CGFloat(col)
        for i in 0...row - 1{
        for j in 0...col - 1{
            let cropImage = imageConvert!.cropping(to: CGRect(x: CGFloat(j)*sizeImage, y: CGFloat(i)*sizeImage, width: sizeImage, height: sizeImage))
            let imageViews = UIImageView(image: UIImage(cgImage: cropImage!))
            imageView.layer.borderWidth = 0.5
            // The color for lines inside photo.
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.frame.origin = CGPoint(x: CGFloat(j)*sizeImage, y: CGFloat(i)*sizeImage)
            view.addSubview(imageView)
            imageView.tag = count
            count += 1
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapimage(gesture:))))
            imageView.isUserInteractionEnabled = true
            imageView.append(imageView)
         }
        }
        imageView.last?.removeFromSuperview()
        imageView.removeLast()
    }
    
    @objc func tapimage(gesture: UITapGestureRecognizer){
        
        let image = gesture.view as! UIImageView
        let x = image.frame.origin
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
                image.frame.origin.x -= move
            }

            return

        }

        
        if checkMove(pos: CGPoint(x: x, y: y + move)){
            UIView.animate(withDuration: 0.2) {
                image.frame.origin.x -= move
            }
            
            return

        }
        
    }
   
       func checkMove(pos:CGPoint) -> Bool{
           let count:[UIImageView] = []
           count = imageView.filter {$0.frame.origin.x - pos.x > -1 && $0.frame.origin.y - pos.y > -1 && $0.frame.origin.y - pos.y < 1 }
           if count == [] && checkOut(pos: pos){
               return true
           }
           return false
        }
        
    func checkOut(pos:CGPoint) -> Bool{
        let top:CGFloat = self.view.frame.height/2 - height/2 //- width/CGFloat(col)
        let left:CGFloat = 0
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
