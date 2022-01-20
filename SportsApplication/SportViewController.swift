//
//  ViewController.swift
//  SportsApplication
//
//  Created by admin on 28/12/2021.
//

import UIKit
import CoreData

class SportViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var sportArr:[SportItem] = []
    @IBOutlet weak var sportTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        sportTableView.dataSource = self
        sportTableView.delegate = self
        fetchSports()
        
        // Do any additional setup after loading the view.
    }
    private func setupTitle() {
        title = "Sport"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func toAddSport(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Sport", message: "Add a new Sport",
                                      preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {     _ in
            
            let newsportname = alert.textFields![0]
            let newSport = SportItem(context: self.context)
            newSport.nameofsport = newsportname.text
           
            self.saveContext()
            self.fetchSports()
            // it can be saved this way too!
//            do {
//                try self.context.save()
//                print("saved new sport")
//            }
//            catch{
//                print (error.localizedDescription)
//            }
         
           
            
            //  let indexPath = IndexPath(row: self.sportArr.count, section: 0)
         //   self.sportTableView.insertRows(at: [indexPath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction -> Void in
        }
        alert.addTextField {
            UITextField -> Void in
        }
     
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}



//MARK: DataCore Functions
extension SportViewController {
    func fetchSports() {
        
        
        let request = NSFetchRequest<SportItem>.init(entityName: "SportItem")
        do{
            sportArr = try context.fetch(request)
            sportTableView.reloadData()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        context.delete(sportArr[indexPath.row])
        saveContext()
        fetchSports()
    }
    
}


//MARK: TableView Functions
extension SportViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sportTableView.dequeueReusableCell(withIdentifier: "sport", for: indexPath)
        let sport = sportArr[indexPath.row]
        
        cell.textLabel?.text = sportArr[indexPath.row].nameofsport
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let PlayersViewController = storyboard?.instantiateViewController(withIdentifier: "PlayersViewController") as! PlayersViewController
        PlayersViewController.sportobj = sportArr[indexPath.row]
        self.navigationController?.pushViewController(PlayersViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    {
        let EditingInfoViewController = storyboard?.instantiateViewController(withIdentifier: "EditingInfoViewController") as! EditingInfoViewController
        EditingInfoViewController.delegate = self
        EditingInfoViewController.sportobj = sportArr[indexPath.row]
        self.navigationController?.pushViewController(EditingInfoViewController, animated: true)
    }
   
}

extension SportViewController : UpdateSportApplication{
    func updateplayer() {
        
   //  fetchSports()
    }
    
    func updateSport() {
        sportTableView.reloadData()
    }
    
    
    
}
