//
//  DadosC.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 17/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import UIKit

let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class DadosC
{
    //listas com os dados para salvar
    var unidades = [UnidadeM]()
    var predios = [PredioM]()
    var salas = [SalaM]()
    var semestres = [SemestreM]()
    var semestresLetivos = [SemestreLetivoM]()
    var cursos = [CursoM]()
    var alocacoes = [AlocacaoSalaM]()
   
    //chave
    var chave = CriptografiaM()
    
    //lista de endereços
    let enderecos = [
        "https://alocacaosalas.unitins.br/getUnidade.php",
        "https://alocacaosalas.unitins.br/getPredio.php",
        "https://alocacaosalas.unitins.br/getSala.php",
        "https://alocacaosalas.unitins.br/getSemestre.php",
        "https://alocacaosalas.unitins.br/getSemestreletivo.php",
        "https://alocacaosalas.unitins.br/getCurso.php",
        "https://alocacaosalas.unitins.br/attAlocacao.php"
    ]
    
    func verificaDados()->Bool{
        var existe = false
        //verifica se existem registros no banco, se todos estiverem ok ele irá
        let unid = UnidadeCD.getAll(moc: managedObjectContext)!
        print("VerificaDados: \(unid)")
        if(unid.count > 0){
            existe = true
        }
        return existe
    }
    
    func buscarDados(){
        //baixa os dados da internet
        let vrUnidades = self.buscaUnidade()
        let vrPredios = self.buscaPredio()
        let vrSalas = self.buscaSalas()
        let vrSemestres = self.buscaSemestre()
        let vrSemestreletivo = self.buscaSemestreletivo()
        
        //salva no banco de acordo com a ordem, percorrendo  a lista de retorno
        for uni in vrUnidades{
            UnidadeCD.save(moc: managedObjectContext,id:uni.id,nome:uni.nome,endereco:uni.endereco,cep:uni.cep,lati:uni.latitude,long:uni.longitude)
            //save(moc:NSManagedObjectContext, id:Int32, nome:String, endereco:String, cep:Int32, lati: Float, long: Float)->UnidadeCD?
            //self.professor?.universidades.insert(universidade!)
            //self.professor?.save()
        }
        
        for pre in vrPredios{
            //do here
        }
        
        for sal in vrSalas{
            //do here
        }
        
        for sem in vrSemestres{
            //do here
        }
        
        for semlet in vrSemestreletivo{
            //do here
        }
        
    }
    
    //busca as unidades
    func buscaUnidade()->[UnidadeM]
    {
        var terminou = false
        let url = URL(string: enderecos[0])!
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "hash=\(chave.chave)".data(using: .utf8)
        request.httpBody = postData
        
        // execute the datatask and validate the result
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.unidades.removeAll()
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let unidade = UnidadeM()
                        unidade.id = (json["id"] as! Int32)
                        unidade.nome = (json["nome"] as! String)
                        unidade.endereco = (json["endereco"] as! String)
                        unidade.cep = (json["cep"] as! Int32)
                        unidade.latitude = (json["latitude"] as! Float)
                        unidade.longitude = (json["longitude"] as! Float)
                        self.unidades.append(unidade)
                    }
                }
            }
            terminou = true
        }.resume()
        //retorna no final
        while !terminou{}
        return unidades
    }
    
    /*
     func buscaUnidade()->[UnidadeCD]
     {
     let url = URL(string: enderecos[0])!
     // post the data
     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     let postData = "hash=\(chave.chave)".data(using: .utf8)
     request.httpBody = postData
     
     // execute the datatask and validate the result
     let session = URLSession.shared
     session.dataTask(with: request) {
     (data, response, error) in
     if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
     //For getting customer_id try like this
     self.unidades.removeAll()
     if let data = userObject!["data"] as? [[String: Any]] {
     for jsonDict in data {
     let json = jsonDict as NSDictionary
     let unidade = UnidadeCD()
     if let numero = json["id"]
     {
     print("AGORA VAI \(numero)")
     let int32 = numero as! Int
     unidade.id = Int32(int32)
     }
     
     unidade.nome = (json["nome"] as! String)
     unidade.endereco = (json["endereco"] as! String)
     unidade.cep = (json["cep"] as! Int32)
     unidade.latitude = (json["latitude"] as! Float)
     unidade.longitude = (json["longitude"] as! Float)
     self.unidades.append(unidade)
     }
     }
     }
     }.resume()
     print("unidades \(self.unidades.count)")
     //retorna no final
     return unidades
     }
     */
    
    //busca os predios
    func buscaPredio()->[PredioM]
    {
        var terminou = false
        let url = URL(string: enderecos[1])!
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "hash=\(chave.chave)".data(using: .utf8)
        request.httpBody = postData
        // execute the datatask and validate the result
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.predios.removeAll()
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let predio = PredioM()
                        predio.id = (json["id"] as! Int32)
                        predio.nome = (json["nome"] as! String)
                        predio.idunidade = (json["idunidade"] as! Int32)
                        predio.pisos = (json["pisos"] as! Int32)
                        predio.ativo = (json["ativo"] as! Bool)
                        predio.unidade = nil
                        self.predios.append(predio)
                    }
                }
            }
            terminou = true
        }.resume()
        //retorna no final
        while !terminou{}
        return predios
    }
    
    //busca as salas
    func buscaSalas()->[SalaM]
    {
        var terminou = false
        let url = URL(string: enderecos[2])!
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "hash=\(chave.chave)".data(using: .utf8)
        request.httpBody = postData
        // execute the datatask and validate the result
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.salas.removeAll()
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let sala = SalaM()
                        sala.id = (json["id"] as! Int32)
                        sala.nome = (json["nome"] as! String)
                        sala.piso = (json["piso"] as! Int32)
                        sala.predio = nil
                        sala.idpredio = (json["idpredio"] as! Int32)
                        sala.tipo = (json["tipo"] as! String)
                        sala.ativo = (json["ativo"] as! Bool)
                        self.salas.append(sala)
                    }
                }
            }
            terminou = true
        }.resume()
        //retorna no final
        while !terminou{}
        return salas
    }
    
    //busca os semestres
    func buscaSemestre()->[SemestreM]
    {
        var terminou = false
        let url = URL(string: enderecos[3])!
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "hash=\(chave.chave)".data(using: .utf8)
        request.httpBody = postData
        // execute the datatask and validate the result
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.semestres.removeAll()
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let semestre = SemestreM()
                        semestre.id = (json["id"] as! Int32)
                        semestre.descricao = (json["descricao"] as! String)
                        //semestre.dataInicio = (json["datainicio"] as! Date)
                        //semestre.dataFim = (json["datafim"] as! Date)
                        self.semestres.append(semestre)
                    }
                }
            }
            terminou = true
        }.resume()
        //retorna no final
        while !terminou{}
        return semestres
    }
    
    //busca os semestres letivos
    func buscaSemestreletivo()->[SemestreLetivoM]
    {
        var terminou = false
        let url = URL(string: enderecos[4])!
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "hash=\(chave.chave)".data(using: .utf8)
        request.httpBody = postData
        // execute the datatask and validate the result
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.semestresLetivos.removeAll()
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let semestreLetivo = SemestreLetivoM()
                        semestreLetivo.id = (json["id"] as! Int32)
                        semestreLetivo.idsemestre = (json["idsemestre"] as! Int32)
                        semestreLetivo.idcurso = (json["idcurso"] as! Int32)
                        self.semestresLetivos.append(semestreLetivo)
                    }
                }
            }
            terminou = true
        }.resume()
        //retorna no final
        while !terminou{}
        return semestresLetivos
    }
    
    //busca os cursos
    func buscaCurso()->[CursoM]
    {
        var terminou = false
        let url = URL(string: enderecos[5])!
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "hash=\(chave.chave)".data(using: .utf8)
        request.httpBody = postData
        // execute the datatask and validate the result
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                //For getting customer_id try like this
                self.cursos.removeAll()
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let curso = CursoM()
                        curso.id = (json["id"] as! Int32)
                        curso.nome = (json["nome"] as! String)
                        curso.unidade = nil
                        curso.codCurso = (json["codcurso"] as! String)
                        curso.idunidade = (json["idunidade"] as! Int32)
                        self.cursos.append(curso)
                    }
                }
            }
            terminou = true
        }
        task.resume()
        while !terminou{}
        //retorna no final
        return cursos
    }
    
    func salvarBanco(){
        
    }
    
}
