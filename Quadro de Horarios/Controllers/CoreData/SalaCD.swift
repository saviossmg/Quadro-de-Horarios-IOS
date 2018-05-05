//
//  SalaCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 16/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class SalaCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var nome:String
    @NSManaged var piso:Int32
    @NSManaged var predio:Predio
    @NSManaged var tipo:String
    @NSManaged var ativo:Bool    
}
