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
        
    }
    
    //Funcao que irá realizar a busca
    @IBAction func acaoOk(_ sender: UIBarButtonItem) {
        print("olaaaaaar")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == semestrePv{
            return semestres.count
        }
        else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == semestrePv{
            //return teste[row]
            return semestres[row].descricao
        }
        else{
            return nil
        }
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
    
}
