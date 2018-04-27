//
//  UnidadeCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 03/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class UnidadeCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var nome:String
    @NSManaged var endereco:String
    @NSManaged var cep:Int32
    @NSManaged var latitude:Float
    @NSManaged var longitude:Float      
}
