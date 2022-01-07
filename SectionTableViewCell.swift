//
//  SectionTableViewCell.swift
//  Puzzles
//
//  Created by noyer altamimi on 25/05/1443 AH.
//

import UIKit

class SectionTableViewCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var imageType: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedImage : UIImage!
      
    var imageViewq = [UIImage]()
    var doSegue : (_:UIImage) -> Void = { image in
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func infoCell(imageType: String, imageViewq : [UIImage] ) {
        self.imageType.text = imageType
        self.imageViewq = imageViewq
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewq.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for : indexPath ) as! ImageCollectionViewCell
        cell.showPhoto.image = imageViewq[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("tapped")
        selectedImage = imageViewq[indexPath.row]
        doSegue(selectedImage)
    }
     
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.width / 2.5 , height: collectionView.frame.height / 1 )

    }
    

    
}

