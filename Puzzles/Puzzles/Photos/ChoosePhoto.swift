//
//  ChoosePhoto.swift
//  Puzzles
//
//  Created by noyer altamimi on 05/05/1443 AH.
//

import UIKit

class ChoosePhoto: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {


    @IBOutlet weak var animalCollectionView: UICollectionView!
    
    @IBOutlet weak var artCollectionView: UICollectionView!
    
    @IBOutlet weak var carsCollectionView: UICollectionView!
    
    @IBOutlet weak var fruitsCollectionView: UICollectionView!
    
    
  

    
    let animalsGallery = [UIImage(named: "animal-1")! ,UIImage(named: "animal-2")! ,UIImage(named: "animal-3")! ,UIImage(named: "animal-4")! ,UIImage(named: "animal-5")! ,UIImage(named: "animal-6")! ,UIImage(named: "animal-7")! ,UIImage(named: "animal-8")! ,UIImage(named: "animal-9")!]
    
    let artGallery = [UIImage(named: "art-1")! ,UIImage(named: "art-2")! ,UIImage(named: "art-3")! ,UIImage(named: "art-4")! ,UIImage(named: "art-5")! ,UIImage(named: "art-6")!]
    
    let carsGallery = [UIImage(named: "car-1")! ,UIImage(named: "car-2")! ,UIImage(named: "car-3")! ,UIImage(named: "car-4")! ,UIImage(named: "car-5")! ,UIImage(named: "car-6")! ,UIImage(named: "car-7")! ,UIImage(named: "car-8")! ,UIImage(named: "car-9")!]
    
    let fruitsGallery = [UIImage(named: "fruits-1")! ,UIImage(named: "fruits-2")! ,UIImage(named: "fruits-3")! ,UIImage(named: "fruits-4")! ,UIImage(named: "fruits-5")! ,UIImage(named: "fruits-6")! ,UIImage(named: "fruits-7")! ,UIImage(named: "fruits-8")! ,UIImage(named: "fruits-9")! ,UIImage(named: "fruits-10")! ,UIImage(named: "fruits-11")!]
   
  
    

    
//  var imageFull : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        animalCollectionView.delegate = self
//        animalCollectionView.dataSource = self

        artCollectionView.delegate = self
        artCollectionView.dataSource = self

//        carsCollectionView.delegate = self
//        carsCollectionView.dataSource = self
//
//        fruitsCollectionView.delegate = self
//        fruitsCollectionView.dataSource = self
       

    }
 
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artGallery.count

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artPhotoCell" , for: indexPath ) as? CollectionViewCell else { return
            UICollectionViewCell( ) }
       cell.artPhoto.image = artGallery[indexPath.row]
        return cell
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: (view.frame.width) / 3.5 , height: (view.frame.height) / 1 )
    }
    
  
    
    
    
    
    
    
    
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
    
 
    
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//
//      guard let viewimage = segue.destination as? HomeVC else { return }
//
//    }
    

   }

