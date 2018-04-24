//
//  SemestreCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 16/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class SemestreCD: NSManagedObject
{

    @NSManaged var id:Int32
    @NSManaged var descricao:String
    @NSManaged var dataInicio:Date
    @NSManaged var dataFim:Date    

}
