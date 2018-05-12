//
//  HorarioConsultaVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 03/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit

class HorarioConsultaVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
     //outlets
    @IBOutlet var semestrePv: UIPickerView!
    @IBOutlet var cursoPv: UIPickerView!
    @IBOutlet var periodoPv: UIPickerView!
    @IBOutlet var salaPv: UIPickerView!
    @IBOutlet var turnoPv: UIPickerView!
    @IBOutlet var diaPv: UIPickerView!
    
    //classe core data
    let findSemestre = SemestreCD()
    let findCurso = CursoCD()
    let findSala = SalaCD()
    
    //classes modelo
    var semestres = [SemestreM]()
    var cursos = [CursoM]()
    var periodos = [PeriodoM]()
    var salas = [SalaM]()
    var turnos = [TurnoM]()
    var dias = [DiaM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pickerview delegate
        semestrePv.delegate = self
        cursoPv.delegate = self
        periodoPv.delegate = self
        salaPv.delegate = self
        turnoPv.delegate = self
        diaPv.delegate = self
        
        //pickerview datasource
        semestrePv.dataSource = self
        cursoPv.dataSource = self
        periodoPv.dataSource = self
        salaPv.dataSource = self
        turnoPv.dataSource = self
        diaPv.dataSource = self
        
        //carrega os dados do combo
        carregaSemestre()
        carregaCurso()
        carregaPeriodo()
        carregaSala()
        carregaTurno()
        carregaDia()
        
    }
    
    //Funcao que irá realizar a busca
    @IBAction func acaoOk(_ sender: UIBarButtonItem) {
        print("olaaaaaar")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
            case semestrePv:
                return semestres.count
            case cursoPv:
                return cursos.count
            case periodoPv:
                return periodos.count
            case salaPv:
                return salas.count
            case turnoPv:
                return turnos.count
            case diaPv:
                return dias.count
            default:
                return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
            case semestrePv:
                return semestres[row].descricao
            case cursoPv:
                return cursos[row].nome
            case periodoPv:
                return periodos[row].descricao
            case salaPv:
                return salas[row].nome
            case turnoPv:
                return turnos[row].descricao
            case diaPv:
                return dias[row].descricao
            default:
                return nil
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var texto = UILabel()
        if let title = view {
            texto = title as! UILabel
        }
        texto.font = UIFont.systemFont(ofSize: 15)
        texto.textColor = UIColor.black
        texto.textAlignment = .center
        
        //seleciona o data source
        switch pickerView {
            case semestrePv:
                texto.text = semestres[row].descricao
            case cursoPv:
                texto.text = cursos[row].nome
            case periodoPv:
                texto.text = periodos[row].descricao
            case salaPv:
                texto.text = salas[row].nome
            case turnoPv:
                texto.text = turnos[row].descricao
            case diaPv:
                texto.text = dias[row].descricao
            default:
                texto.text = ""
        }
        return texto
        
    }
    
    //metodos de carregamento
    func carregaSemestre(){
        let aux = SemestreM()
        aux.id = 0
        aux.descricao = "SEMESTRE - Obrigatório selecionar"
        semestres.append(aux)
        let lista = findSemestre.listar()
        for load in lista
        {
            semestres.append(load)
        }
    }
    
    func carregaCurso(){
        let aux = CursoM()
        aux.id = 0
        aux.nome = "CURSO"
        cursos.append(aux)
        let lista = findCurso.listar()
        for load in lista
        {
            cursos.append(load)
        }
    }
    
    func carregaPeriodo(){
        var aux = PeriodoM()
        aux.num = -1
        aux.descricao = "PERÍODO"
        periodos.append(aux)
        for load in 0...10
        {
            aux = PeriodoM()
            aux.num = load
            if load == 0 {
                aux.descricao = "Regularização/Especial"
            }
            else{
                aux.descricao = "\(load)º Período"
            }
            periodos.append(aux)
        }
    }
    
    func carregaSala(){
        let aux = SalaM()
        aux.id = 0
        aux.nome = "SALA"
        salas.append(aux)
        let lista = findSala.listar()
        for load in lista
        {
            salas.append(load)
        }
    }
    
    func carregaTurno(){
        var aux = TurnoM()
        aux.id = 0
        aux.descricao = "TURNO"
        turnos.append(aux)
        aux = TurnoM()
        aux.id = 9
        aux.descricao = "Matutino"
        turnos.append(aux)
        aux = TurnoM()
        aux.id = 10
        aux.descricao = "Vespertino"
        turnos.append(aux)
        aux = TurnoM()
        aux.id = 11
        aux.descricao = "Noturno"
        turnos.append(aux)
    }
    
    func carregaDia(){
        var aux = DiaM()
        aux.id = 0
        aux.descricao = "DIA"
        dias.append(aux)
        aux = DiaM()
        aux.id = 13
        aux.descricao = "Segunda-Feira"
        dias.append(aux)
        aux = DiaM()
        aux.id = 14
        aux.descricao = "Terça-Feira"
        dias.append(aux)
        aux = DiaM()
        aux.id = 15
        aux.descricao = "Quarta-Feira"
        dias.append(aux)
        aux = DiaM()
        aux.id = 16
        aux.descricao = "Quinta-Feira"
        dias.append(aux)
        aux = DiaM()
        aux.id = 17
        aux.descricao = "Sexta-Feira"
        dias.append(aux)
        aux.id = 18
        aux.descricao = "Sábado"
        dias.append(aux)
    }

    
}
