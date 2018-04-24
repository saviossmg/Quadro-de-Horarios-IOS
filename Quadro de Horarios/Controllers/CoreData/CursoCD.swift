//
//  CursoCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 16/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class CursoCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var nome:String
    @NSManaged var unidade:UnidadeCD
    @NSManaged var codCurso:String
    @NSManaged var idunidade:Int32
    
}
