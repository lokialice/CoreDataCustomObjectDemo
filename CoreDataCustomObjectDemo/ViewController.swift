//
//  ViewController.swift
//  CoreDataCustomObjectDemo
//
//  Created by Macbook Pro MD102 on 5/12/15.
//  Copyright (c) 2015 Macbook Pro MD102. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet var txtUsername: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func btnSave(sender: UIButton) {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
        
        var newUser = Users(entity:ent!,insertIntoManagedObjectContext:context)
        newUser.username = txtUsername.text
        newUser.password =  txtPassword.text
        
        context.save(nil)
        println(newUser)
        println("Object Save")
        
    
    }
    
    @IBAction func btnLoad(sender: UIButton) {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username =  %@",txtUsername.text)
        
        var result:NSArray = context.executeFetchRequest(request, error: nil)!
        if(result.count > 0){
            println("\(result.count) found")
            for user in result {
                var thisUser = user as! Users
                println(thisUser.toString())
                thisUser.addFunnyPrefix("haha-")
                println(thisUser.toString())
            }
        }else {
            println("No result found")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

