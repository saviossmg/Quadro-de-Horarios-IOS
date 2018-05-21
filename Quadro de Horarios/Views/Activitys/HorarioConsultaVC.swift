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
    
    //indices
    var indices:[Int] = [0,0,0,0,0,0]
    
    //classe que vai puxar o dado da internet
    let download = OfertaD()
    
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
        //o semestre é obrigatorio
        if indices[0] == 0 {
            let msg = "Selecione o semestre!"
            let alert = UIAlertController(title: "Atenção", message: "\(msg)", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let seme = semestres[indices[0]].id
            let cur = cursos[indices[1]].id
            let per = periodos[indices[2]].num
            let sal = salas[indices[3]].id
            let tur = turnos[indices[4]].id
            let dia = dias[indices[4]].id
            let task = download.preparaDownload(semestre: seme!,curso: cur!,periodo: per!,sala: sal!,turno: tur!,dia: dia!)
            var msg = ""
            if task {
                msg = "Consulta realizada com sucesso!\nLista Alterada de acordo com os parâmetros"
                //armazena os parametros da consulta
                StoreManager.gravaPreferencias(semestre: seme!, curso: cur!, periodo: per!, sala: sal!, turno: tur!, dia: dia!)
                let alert = UIAlertController(title: "Sucesso", message: "\(msg)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                    (_)in
                    self.performSegue(withIdentifier: "unwindToMenu", sender: self)
                })
                
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                /*
                let alert = UIAlertController(title: "Atenção", message: "\(msg)", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "unwindToMenu", sender: self)
                */
            }
            else{
                msg = "Falha no processo!"
                let alert = UIAlertController(title: "Atenção", message: "\(msg)", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }            
            
        }
        
    }
    
    func numberOfComponents (in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //retorna o contador do picker view
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
    
    //retorna a descricao
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
    
    //altera a formataçao do texto
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
            case semestrePv:
                self.indices[0] = row
            case cursoPv:
                self.indices[1] = row
            case periodoPv:
                self.indices[2] = row
            case salaPv:
                self.indices[3] = row
            case turnoPv:
                self.indices[4] = row
            case diaPv:
                self.indices[5] = row
            default:
                print("h")
        }
    }
    
    //metodos de carregamento
    func carregaSemestre(){
        semestres.removeAll()
        let aux = SemestreM()
        aux.id = 0
        aux.descricao = "SEMESTRE - Obrigatório selecionar"
        semestres.append(aux)
        let lista = findSemestre.listar()
        for load in lista
        {
            if load.descricao != nil {
                semestres.append(load)
            }
        }
    }
    
    func carregaCurso(){
        cursos.removeAll()
        let aux = CursoM()
        aux.id = 0
        aux.nome = "CURSO"
        cursos.append(aux)
        let lista = findCurso.listar()
        for load in lista
        {
            if load.nome != nil {
                cursos.append(load)
            }
            
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
        salas.removeAll()
        let aux = SalaM()
        aux.id = 0
        aux.nome = "SALA"
        salas.append(aux)
        let lista = findSala.listar()
        for load in lista
        {
            if(load.nome != nil){
                salas.append(load)
            }
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
