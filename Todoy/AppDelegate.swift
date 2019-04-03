//
//  AppDelegate.swift
//  Todoy
//
//  Created by Basma Said on 3/8/19.
//  Copyright © 2019 Basma Said. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //print(Realm.Configuration.defaultConfiguration.fileURL)
      
        
        do{
            _ = try Realm()  //this line equivelant for the next just because we are not going to use realm again we can replaced by_
            
           //let realm = try Realm()
        }catch{
            print("error instialising new Realm,\(error)")
        }
        
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
        
        //used this print satatmnet before to no the path of the plist file of defauls print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
        //to print the path of the plist file that saved the data in
        return true
    }

}



