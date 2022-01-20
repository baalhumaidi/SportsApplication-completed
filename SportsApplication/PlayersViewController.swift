//
//  PlayersViewController.swift
//  SportsApplication
//
//  Created by admin on 28/12/2021.
//

import UIKit
import CoreData

class PlayersViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var playersList:[Players] = []
    var sportobj:SportItem?
    
    var delegate : UpdateSportApplication?
    
    @IBOutlet weak var playerTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupBarButtonItem()
        playerTableView.dataSource = self
        playerTableView.delegate = self
        fetchPlayers()
        // Do any additional setup after loading the view.
    }
    
    private func setupTitle() {
        if let nameofsport = sportobj?.nameofsport
        {  title = String("players for \(nameofsport)")
            navigationController?.navigationBar.prefersLargeTitles = true}
    }
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(addPlayer)
        )
    }
    
    
    //add button to add new player
    @objc private func addPlayer(){
        let alert = UIAlertController(title: "New Sport", message: "Add a new Sport",
                                      preferredStyle: .alert)
      //  let newRowIndex = self.sportobj?.players?.count
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let textField = alert.textFields![0]
            let textField1 = alert.textFields![1]
            let textField2 = alert.textFields![2]
            
            let newplayer = Players(context: self.context)
            newplayer.name = textField.text
            if let agetoInt: Int16 = Int16(textField1.text!), let heightToInt: Int16 = Int16(textField2.text!){
                newplayer.age = agetoInt
                newplayer.height = heightToInt
            }
            self.sportobj?.addToPlayers(newplayer)
                       self.saveContext()
//            do{
//                try self.context.save()
//                print("new player saved")
//            }
//            catch{
//                print(error.localizedDescription)
//                print("new player not saved")
//            }
            
            
        //    let indexPath = IndexPath(row: newRowIndex!, section: 0)
        //    self.tableView.insertRows(at: [indexPath], with: .bottom)
            self.fetchPlayers()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction -> Void in
        }
        alert.addTextField {
            UITextField -> Void in
        }
        alert.addTextField {
            UITextField -> Void in
        }
        alert.addTextField {
            UITextField -> Void in
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
}



//MARK: DataCore Functions

extension PlayersViewController {
    
    func fetchPlayers(){
        // 
        let request = NSFetchRequest<Players>.init(entityName: "Players")
        do{

            playersList = try context.fetch(request)
            playerTableView.reloadData()
        }
        catch {
            print("error")
        }
    }
    //MARK: Delete Player
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if let playerArr = sportobj?.players?.allObjects as? [Players]{
         context.delete(playerArr[indexPath.row])
         saveContext()
             playerTableView.reloadData()
         }

    }
}

//MARK: TableView Functions


extension PlayersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let playerArr = sportobj?.players{
            return playerArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "player", for: indexPath)
        
        if let playerArr = sportobj?.players?.allObjects as? [Players]{
            let playerObj = playerArr[indexPath.row]
            if let name = playerObj.name{
                cell.textLabel?.text = String("name:\(name), age:\(playerObj.age), height:\(playerObj.height)")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let EditingInfoViewController = storyboard?.instantiateViewController(withIdentifier: "EditingInfoViewController") as! EditingInfoViewController
        //        EditingInfoViewController.sportobj = sportobj?.players
        EditingInfoViewController.delegate = self
        if let playerArr = sportobj?.players?.allObjects as? [Players]{
            let playerObj = playerArr[indexPath.row]
            EditingInfoViewController.playerobj = playerObj
        }
        self.navigationController?.pushViewController(EditingInfoViewController, animated: true)
        
    }
    
    
    
}

extension PlayersViewController : UpdateSportApplication{
    func updateplayer() {
        playerTableView.reloadData()
    }
    
    func updateSport() {
     
    }
    
    
}

