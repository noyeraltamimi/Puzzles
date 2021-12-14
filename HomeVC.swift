//
//  HomeVC.swift
//  Puzzles
//
//  Created by noyer altamimi on 05/05/1443 AH.
//

import UIKit
import Foundation
import CoreData
import PhotosUI


class HomeVC: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    var selectedImage : UIImage!
    var filledName : String = ""
    
    var players : [Player] = []

    let persistentContainer : NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Puzzles")
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print(error)
            }
            
        })
        
        return container
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchMyContacts()
        tableView.reloadData()
        //viewImage.image = setSelectImage
        
        
}
    
    
    func fetchMyContacts() {
        
        let context = persistentContainer.viewContext
        
        do {
            players =  try context.fetch(Player.fetchRequest())
        } catch {
            print(error)
        }
        
    }
    
    
    func createNewPlayer( name : String, pic : Data) {
        let context = persistentContainer.viewContext
        
        context.performAndWait {
            let newPlayer = Player(context: context)
            newPlayer.name = name
            newPlayer.pic = pic
        }
        
        do {
         try context.save()
        }
        catch {
            print(error)
        }
    }
    

    @IBAction func AddButton(_ sender: Any) {
    
        
            let alert = UIAlertController(title: "Add Friend", message: "", preferredStyle: .alert)
                
    
        
        let openPic = UIAlertAction(title: "add Image", style: .default , handler: { action in
            if let nameFromTextField = alert.textFields?[0].text {
                self.filledName = nameFromTextField
            }
            
            self.tableView.reloadData()
            
            self.presentPhotoPicker()
        })
        
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addTextField { textFiledSet in
                textFiledSet.placeholder = "Friend Name.."
                
            }
        
        alert.addAction(openPic)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
            
        }
        

        override func numberOfSections(in tableView: UITableView) -> Int {
           
            return 1
            
        }
        
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
            return players.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellUsers", for: indexPath)
            cell.textLabel?.text = players[indexPath.row].name
            cell.imageView?.image = UIImage(data: players[indexPath.row].pic!)

            return cell
        
        }
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images

        let photoPicker = PHPickerViewController(configuration: configuration)
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)

        if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let image = image as? UIImage {
              
                    self.selectedImage = image
                    
                    DispatchQueue.main.async {
                       
                        self.setNewPlayer()
                        //self.myImageView.image = image
                    }
                }
            }
        }
    }
    
    
    
    func setNewPlayer(){
        createNewPlayer(name: filledName , pic: selectedImage.jpegData(compressionQuality: 0.8)!)
        fetchMyContacts()
        tableView.reloadData()
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        
        dismiss(animated: true, completion: nil)

        
        let image = info[.originalImage] as! UIImage
        self.selectedImage = image
        self.setNewPlayer()
      //  myImageView.image = image

        
     //   imgStore.setImage(image, forKey: myFavImage)

    }

    
}
     
