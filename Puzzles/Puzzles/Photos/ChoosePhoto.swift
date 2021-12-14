//
//  ChoosePhoto.swift
//  Puzzles
//
//  Created by noyer altamimi on 05/05/1443 AH.
//

import UIKit

class ChoosePhoto: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {


    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var selectImage = UIImage(named: "" )
    let photoGallery = [UIImage(named: "Image-1")! ,UIImage(named: "Image-2")! ,UIImage(named: "Image-3")! ,UIImage(named: "Image-4")!  ,UIImage(named: "Image")!]


    
    var imageFull : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoGallery.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell" , for: indexPath ) as? CollectionViewCell else { return
            UICollectionViewCell( ) }
     //   cell.photo.image = photoGallery[indexPath.row]
        return cell
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: (view.frame.width) / 3 , height: (view.frame.height) / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


 
        guard let viewimage = segue.destination as? HomeVC else { return }
                
    }
    

    }

