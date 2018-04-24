//
//  OfertaCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 16/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class OfertaCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var nometurma:String
    @NSManaged var curso:CursoCD
    @NSManaged var diasemana:String
    @NSManaged var periodo:Int32
    @NSManaged var disciplina:String
    @NSManaged var descricaoperiodoletivo:String
    @NSManaged var horainiciala:String
    @NSManaged var horafinala:String
    @NSManaged var intervaloinicio:String
    @NSManaged var intervalofim:String
    @NSManaged var horainicialb:String
    @NSManaged var horafinalb:String
    @NSManaged var professor:String
    @NSManaged var turno:String
    @NSManaged var tipohorario:Int32
    @NSManaged var idcurso:Int32
}
