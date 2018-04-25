//
//  ViewController.swift
//  testphotostocloud
//
//  Created by Lauren Traum on 3/2/18.
//  Copyright © 2018 Lauren Traum. All rights reserved.
//
//this is Lauren. Lauren. Lauren

import UIKit
import Firebase
import GoogleSignIn


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // placeholder
    }
    
    var foundItems: DatabaseReference!
    
    
    
    
    
    @IBOutlet weak var PhotoLibrary: UIButton!
    
    @IBOutlet weak var Camera: UIButton!
    
    @IBOutlet weak var ImageDisplay: UIImageView!
    
    var foundItemsList = [FoundItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foundItems = Database.database().reference().child("foundItems");
        
        //observing the data changes
        foundItems.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.foundItemsList.removeAll()
                
                //iterating through all the values
                for foundItems in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let foundObject = foundItems.value as? [String: AnyObject]
                    let foundItemLocation  = foundObject?["foundItemLocation"]
                    let foundItemDescription  = foundObject?["foundItemDescription"]
                    let foundItemDateFound = foundObject?["foundItemDateFound"]
                    let foundItemId = foundObject?["id"]
                    
                    //creating artist object with model and fetched values  *************************
                    let foundItem = FoundItemModel(id: foundItemId as! String?, dateFound: foundItemDateFound as! String?, description: foundItemDescription as! String?, location: foundItemLocation as! String?)
                    
                    //appending it to list
                    self.foundItemsList.append(foundItem)
                }
                
                //reloading the tableview
                //self.tableViewArtists.reloadData()
            }
        })
        
        // Doing in AppDelegate.swift
        //GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        foundItems = Database.database().reference().child("found items")
        
        print()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addFoundItem(){
        let key = foundItems.childByAutoId().key
        let foundItem = ["id":key,
                         "foundItemLocation" : "Bourn Lab",
                         "foundItemDescription":"blue nalgene waterbottle",
                         "foundItemDateFound": "4/1/18"]
        foundItems.child(key).setValue(foundItem)
        print("item added")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func submit(_ sender: UIButton) {
        addFoundItem()
    }
    
    
    @IBAction func PhotoLibraryAction(_ sender: UIButton) {
        
       let picker = UIImagePickerController()
        
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func CameraAction(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        
        
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        ImageDisplay.image=info[UIImagePickerControllerOriginalImage] as? UIImage; dismiss(animated: true, completion: nil)
    }
    
    
}

