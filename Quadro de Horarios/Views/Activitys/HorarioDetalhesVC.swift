//
//  HorarioDetalhesVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 19/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit

class HorarioDetalhesVC: UIViewController {

    @IBOutlet var vrDisciplina: UILabel!
    @IBOutlet var vrSemestreletivo: UILabel!
    @IBOutlet var vrCurso: UILabel!
    @IBOutlet var vrPeriodo: UILabel!
    @IBOutlet var vrDia: UILabel!
    @IBOutlet var vrTurno: UILabel!
    @IBOutlet var vrHorario1: UILabel!
    @IBOutlet var vrIntervalo: UILabel!
    @IBOutlet var vrHorario2: UILabel!
    @IBOutlet var vrLocal: UILabel!
    
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
        vrDisciplina.text = disciplina
        vrSemestreletivo.text = semestreletivo
        vrCurso.text = curso
        vrPeriodo.text = periodo
        vrDia.text = dia
        vrTurno.text = turno
        vrHorario1.text = horario1
        vrIntervalo.text = intervalo
        vrHorario2.text = horario2
        vrLocal.text = local
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
