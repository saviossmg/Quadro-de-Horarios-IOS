//
//  PredioCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 03/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class PredioCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var nome:String
    @NSManaged var idunidade:Int32
    @NSManaged var pisos:Int32
    @NSManaged var ativo:Bool
    @NSManaged var unidade:UnidadeCD  
}
