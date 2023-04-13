//
//  ViewController.swift
//  Core_Database
//
//  Created by R82 on 06/04/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var t1: UITextField!
    @IBOutlet weak var t2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


    @IBAction func addButtonAction(_ sender: Any) {
        if let x = t1.text,let y = Int(x){
            addData(id: y, name: t2.text ?? "")
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        if let x = t1.text,let y = Int(x){
        deleteData(id: y)
        }
    }
    @IBAction func getButtonAction(_ sender: Any) {
        getData()
    }
    func addData(id:Int,name:String){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageConext = appDeleget.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Students", in: manageConext)
        let user = NSManagedObject(entity: userEntity!, insertInto: manageConext)
        user.setValue(id, forKey: "id")
        user.setValue(name, forKey: "name")
        print(user)
    }
    func getData(){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageConext = appDeleget.persistentContainer.viewContext
        let fetchRequest = Students.fetchRequest()
        do{
            let result = try manageConext.fetch(fetchRequest)
            for data in result{
                print(data.name as! String, data.id )
            }
            print("data fetched")
        }
        catch{
            print("data not fetched")
        }
        
    }
    func updateData(){
        
    }
    func deleteData(id:Int){
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageConext = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do{
            let test = try manageConext.fetch(fetchRequest)
            let objToDelete = test[0] as! NSManagedObject
            manageConext.delete(objToDelete)
            appDeleget.saveContext()
            print("delete data")
        }
        catch{
            print(error)
        }
    }
}

