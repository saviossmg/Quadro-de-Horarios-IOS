//
//  AlocacaoSalaCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 16/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class AlocacaoSalaCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var semestre:SemestreLetivo
    @NSManaged var sala:Sala
    @NSManaged var oferta:Oferta
	
}
