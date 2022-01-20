//
//  EditingInfoViewController.swift
//  SportsApplication
//
//  Created by admin on 28/12/2021.
//

import UIKit


protocol UpdateSportApplication{
    func updateplayer()
    func updateSport()
}

class EditingInfoViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var delegate : UpdateSportApplication?
    @IBOutlet weak var first: UITextField!
    
    
    @IBOutlet weak var second: UITextField!
    
    @IBOutlet weak var third: UITextField!
    var sportobj: SportItem?
    var playerobj : Players?
    var name : String?
    var age,height: Int16?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if playerobj != nil{
            first.text = playerobj?.name
            let ageInt = Int(playerobj!.age)
            
            second.text = String(ageInt)
            third.text = String(Int(playerobj!.height))
            
        }
        else if sportobj != nil {
            first.text = sportobj?.nameofsport
            second.isHidden = true
            third.isHidden = true
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UpdateData(_ sender: UIButton) {
        
        if playerobj != nil {
            playerobj?.name = first.text
            let stringAge = second.text!
            let stringHeight = third.text!
            if let agetoInt : Int16 = Int16(stringAge), let heightToInt : Int16 = Int16(stringHeight){
                playerobj!.age = agetoInt
                playerobj!.height = heightToInt
            }
            do {
                try context.save()
                print("saved new player")
            }
            catch{
                print (error.localizedDescription)
            }
          //  saveContext()
            delegate?.updateplayer()
            
        }
        else
            if sportobj != nil {
                sportobj?.nameofsport = first.text
                //saveContext()
                do {
                    try context.save()
                    print("saved new sport")
                    delegate?.updateSport()
                }
                catch{
                    print (error.localizedDescription)
                }
                
            
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    

    
}
