//
//  GerenciadorCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 04/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContextoCD
{
    var contexto:NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
        
}
