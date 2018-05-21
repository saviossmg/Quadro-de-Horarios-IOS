//
//  StoreManager.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 17/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation

class StoreManager
{
    //Metodo de classe utilizado para persistir os dados
    class func gravaPreferencias(semestre:Int32,curso: Int32, periodo:Int,sala:Int32,turno:Int32,dia:Int32)
    {
        let defaults = UserDefaults.standard
        defaults.set(semestre, forKey: "semestre")
        defaults.set(curso, forKey: "curso")
        defaults.set(periodo, forKey: "periodo")
        defaults.set(sala, forKey: "sala")
        defaults.set(turno, forKey: "turno")
        defaults.set(dia, forKey: "dia")
        defaults.synchronize()
    }
    
    //Metodo de classe utililado para recuperar os dados persistidos
    class func retornaPreferencias()->(semestre:Int32,curso: Int32, periodo:Int32,sala:Int32,turno:Int32,dia:Int32)
    {
        let defaults = UserDefaults.standard
        let semestre = Int32(defaults.integer(forKey: "semestre"))
        let curso = Int32(defaults.integer(forKey: "curso"))
        let periodo = Int32(defaults.integer(forKey: "periodo"))
        let sala = Int32(defaults.integer(forKey: "sala"))
        let turno = Int32(defaults.integer(forKey: "turno"))
        let dia = Int32(defaults.integer(forKey: "dia"))
        return (semestre, curso, periodo,sala, turno, dia)
    }
    
}

