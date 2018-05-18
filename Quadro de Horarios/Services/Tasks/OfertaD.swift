//
//  OfertaD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 14/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import UIKit

class OfertaD
{
    //modelos de dados
    var ofertas = [OfertaM]()
    var alocacoes = [AlocacaoSalaM]()
    
    //chave
    let chave = CriptografiaM()
    
    //controladores do banco com funcoes do core data
    let ofertaC =  OfertaCD()
    let alocacaoC = AlocacaoSalaCD()
    
    //lista de endereços
    let endereco = "https://alocacaosalas.unitins.br/getAlocacao.php"
    
    //funcao qque irá baixar os dados da internet
    func preparaDownload(semestre:Int32,curso: Int32, periodo:Int,sala:Int32,turno:Int32,dia:Int32)->Bool{
        var terminou = false
        //pega os parametros, verifica o que vem vazio e adiicona conforme as condições estabelecidas
        var postData = "hash=\(chave.chave)"
        if semestre != 0 {
            postData.append("&semestre=\(semestre)")
        }
        if curso != 0 {
            postData.append("&curso=\(curso)")
        }
        if periodo != -1{
            postData.append("&periodo=\(periodo)")
        }
        if sala != 0 {
            postData.append("&periodo=\(sala)")
        }
        if turno != 0 {
            postData.append("&turno=\(turno)")
        }
        if dia != 0 {
            postData.append("&dia=\(dia)")
        }
        
        // post the data
        let parametros = postData.data(using: .utf8)
        do{
            //baixa os dados
            try baixaDados(param: parametros)
            //salva os dados no banco
            try salvaDados()
            terminou = true
        } catch  {
            print("EXCECAO: \(error)")
        }
        return terminou
    }
    
    func baixaDados(param: Data?) throws {
        //pega os parametros, verifica o que vem vazio e adiicona conforme as condições estabelecidas
        var terminou = false
        let url = URL(string: endereco)!
        
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parametros = param
        request.httpBody = parametros
        
        //execute the datatask and validate the result
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.ofertas.removeAll()
                self.alocacoes.removeAll()
                if let dataOfer = userObject!["ofer"] as? [[String: Any]] {
                    for jsonDict in dataOfer {
                        let json = jsonDict as NSDictionary
                        let oferta = OfertaM()
                        oferta.id = (json["id"] as! Int32)
                        oferta.descricaoperiodoletivo = (json["descricaoperiodoletivo"] as! String)
                        oferta.diasemana = (json["diasemana"] as! String)
                        oferta.disciplina = (json["disciplina"] as! String)
                        //esses horarios podem vir nulos
                        if(json["horainiciala"] is NSNull){ oferta.horainiciala = "" }
                        else{ oferta.horainiciala = (json["horainiciala"] as! String)}
                        //
                        if(json["horainicialb"] is NSNull){ oferta.horainicialb = "" }
                        else{ oferta.horainicialb = (json["horainicialb"] as! String)}
                        //
                        if(json["intervaloinicio"] is NSNull){ oferta.intervaloinicio = "" }
                        else{ oferta.intervaloinicio = (json["intervaloinicio"] as! String)}
                        //
                        if(json["intervalofim"] is NSNull){ oferta.intervalofim = "" }
                        else{ oferta.intervalofim = (json["intervalofim"] as! String)}
                        //
                        if(json["horafinala"] is NSNull){ oferta.horafinala = "" }
                        else{ oferta.horafinala = (json["horafinala"] as! String)}
                        //
                        if(json["horafinalb"] is NSNull){ oferta.horafinalb = "" }
                        else{ oferta.horafinalb = (json["horafinalb"] as! String)}
                        //
                        oferta.idcurso = (json["idcurso"] as! Int32)
                        oferta.nometurma = (json["nometurma"] as! String)
                        let periodo = (json["periodo"] as! Int)
                        if periodo == 0 {
                            oferta.periodo = "Refularização/Oferta Especial"
                        }else{
                            oferta.periodo = "\(periodo)º Período"
                        }
                        oferta.professor = (json["professor"] as! String)
                        oferta.turno = (json["turno"] as! String)
                        self.ofertas.append(oferta)
                    }
                }
                
                if let datAloc = userObject!["aloc"] as? [[String: Any]] {
                    for jsonDict in datAloc {
                        let json = jsonDict as NSDictionary
                        let alocacao = AlocacaoSalaM()
                        alocacao.id = (json["id"] as! Int32)
                        alocacao.idoferta = (json["idoferta"] as! Int32)
                        alocacao.idsala = (json["idsala"] as! Int32)
                        alocacao.idsemestre = (json["idsemestre"] as! Int32)
                        self.alocacoes.append(alocacao)
                        
                    }
                }
            }
            terminou = true
            }.resume()
        //retorna no final
        while !terminou{}
    }
    
    func salvaDados() throws {
        //laço para salvar a info no banco
        //primeiro vai veirifcar se existe no banco
        //se nao ele vai salvar, se sim ele pula
        //primeiro as ofertas e depois as alocacoes
        for aux in ofertas {
            let objOferta:OfertaM! = ofertaC.findById(id: aux.id)
            if objOferta == nil {
                ofertaC.salvar(obj: aux)
            }
        }
        for aux in alocacoes{
            let objAloc:AlocacaoSalaM! = alocacaoC.findById(id: aux.id)
            if objAloc == nil {
                alocacaoC.salvar(obj: aux)
            }
        }
    }
    
    
}
