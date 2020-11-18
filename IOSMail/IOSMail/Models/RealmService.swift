//
//  RealmService.swift
//  iosMail
//
//  Created by student on 2020-11-18.
//

import Foundation
import RealmSwift 
class RealmService {
    
    private init(){}
    
    var realm = try! Realm()
    
    func create<T:Object>(_ object: T)  {
        do {
            try realm.write{
                
            }
        } catch <#pattern#> {
            <#statements#>
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
