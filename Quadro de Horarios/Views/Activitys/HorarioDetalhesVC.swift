//
//  HorarioDetalhesVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 19/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit

class HorarioDetalhesVC: UIViewController {

    @IBOutlet var lbDisciplina: UILabel!
    @IBOutlet var lbSemestreletivo: UILabel!
    @IBOutlet var lbCurso: UILabel!
    @IBOutlet var lbPeriodo: UILabel!
    @IBOutlet var lbDia: UILabel!
    @IBOutlet var lbTurno: UILabel!
    @IBOutlet var lbHorario1: UILabel!
    @IBOutlet var lbIntervalo: UILabel!
    @IBOutlet var lbHorario2: UILabel!
    @IBOutlet var lbLocal: UILabel!
    
    //Variavies da classe (stored properties)
    var disciplina:String!
    var semestreletivo:String!
    var curso:String!
    var periodo:String!
    var dia:String!
    var turno:String!
    var horario1:String!
    var intervalo: String!
    var horario2: String!
    var local: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //seta os textos
        lbDisciplina.text = disciplina
        lbSemestreletivo.text = semestreletivo
        lbCurso.text = curso
        lbPeriodo.text = periodo
        lbDia.text = dia
        lbTurno.text = turno
        lbHorario1.text = horario1
        lbIntervalo.text = intervalo
        lbHorario2.text = horario2
        lbLocal.text = local
    }    

}
