//
//  PhotosGallery.swift
//  Puzzles
//
//  Created by noyer altamimi on 25/05/1443 AH.
//

import UIKit

class PhotosGallery: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var theName: UINavigationItem!
    
    
    
    var selectedImage: UIImage!
    
    var arrInfo = [Gallery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        arrInfo.append(Gallery(photoName: "Animal", theImage: [ UIImage( named: "animal-1")!,UIImage( named: "animal-2")!,UIImage( named: "animal-3")!,UIImage( named: "animal-4")!,UIImage( named: "animal-5")!,UIImage( named: "animal-6")!,UIImage( named: "animal-7")!,UIImage( named: "animal-8")!]))

        arrInfo.append(Gallery(photoName: "Art", theImage: [ UIImage(named: "art-1")!,UIImage( named: "art-2")!,UIImage( named: "art-3")! ,UIImage( named: "art-4")! ,UIImage( named: "art-5")!,UIImage( named: "art-6")! ]))

        arrInfo.append(Gallery(photoName: "Fruit", theImage: [ UIImage( named: "fruits-1")!,UIImage( named: "fruits-2")!,UIImage( named: "fruits-3")! ,UIImage( named: "fruits-4")!,UIImage( named: "fruits-5")!,UIImage( named: "fruits-6")!,UIImage( named: "fruits-7")!,UIImage( named: "fruits-8")!,UIImage( named: "fruits-9")!,UIImage( named: "fruits-10")!,UIImage( named: "fruits-11")! ]))
        
        arrInfo.append(Gallery(photoName: "Car", theImage: [ UIImage( named: "car-1")!,UIImage( named: "car-2")!,UIImage( named: "car-3")!,UIImage( named: "car-4")!,UIImage( named: "car-5")!,UIImage( named: "car-6")!,UIImage( named: "car-7")!,UIImage( named: "car-8")!]))

}

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SectionTableViewCell
        let callGallery = arrInfo[indexPath.row]
        cell.infoCell(imageType: callGallery.photoName, imageViewq: callGallery.theImage)
        
        cell.doSegue = { image in
            self.selectedImage = cell.selectedImage
            self.performSegue(withIdentifier: "moveToGame", sender: nil)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        let cell = tableView.cellForRow(at: indexPath) as! SectionTableViewCell
        selectedImage = cell.selectedImage
        performSegue(withIdentifier: "moveToGame", sender: nil)
       // selectedImage = callGallery.theImage
//        if let createPuzzle =
//        = arrInfo.[indexPath].theImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToGame" {
            
            if let destination = segue.destination as? GameVC {
                destination.selctedimage = selectedImage
            }
            
        }
    }
    
    
}

struct Gallery {
    
 let photoName : String
 let theImage : [UIImage]
    
}




