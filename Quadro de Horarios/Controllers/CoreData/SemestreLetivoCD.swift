//
//  SemestreLetivoCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 16/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class SemestreLetivoCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var semestre:SemestreCD
    @NSManaged var curso:CursoCD
    @NSManaged var idsemestre:Int32
    @NSManaged var idcurso:Int32
}
