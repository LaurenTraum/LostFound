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


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInUIDelegate {
    var foundItems: DatabaseReference!
    
    @IBOutlet weak var PhotoLibrary: UIButton!
    
    @IBOutlet weak var Camera: UIButton!
    
    @IBOutlet weak var ImageDisplay: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        FirebaseApp.configure()
        foundItems = Database.database().reference().child("found items")
        
        
        
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

