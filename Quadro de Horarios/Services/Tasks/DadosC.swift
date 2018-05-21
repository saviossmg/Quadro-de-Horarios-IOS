//
//  DadosC.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 17/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import UIKit

class DadosC
{
    //modelos de dados
    var unidades = [UnidadeM]()
    var predios = [PredioM]()
    var salas = [SalaM]()
    var semestres = [SemestreM]()
    var semestresLetivos = [SemestreLetivoM]()
    var cursos = [CursoM]()
    var ofertas = [OfertaM]()
    var alocacoes = [AlocacaoSalaM]()
   
    //chave
    var chave = CriptografiaM()
    
    //controladores do banco com funcoes do core data
    let unidadeC =  UnidadeCD()
    let predioC = PredioCD()
    let salaC = SalaCD()
    let semestreC = SemestreCD()
    let cursoC = CursoCD()
    let semestreLetivoC = SemestreLetivoCD()
    let ofertaC = OfertaCD()
    let alocacaoC = AlocacaoSalaCD()
    
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
        //lista os registros do banco
        unidades = unidadeC.listar()
        predios = predioC.listar()
        salas = salaC.listar()
        semestres = semestreC.listar()
        cursos = cursoC.listar()
        semestresLetivos = semestreLetivoC.listar()
        
        //verifica se existem registros no banco, se todos estiverem ok ele irá
        if(unidades.count > 0 && predios.count > 0 && salas.count > 0 && semestres.count > 0 && cursos.count > 0 && semestresLetivos.count > 0){
            existe = true
        }
        return existe
    }
    
    func buscarDados(sincronia: Bool)->String{
        //baixa os dados da internet
        let vrUnidades = self.buscaUnidade()
        let vrPredios = self.buscaPredio()
        let vrSalas = self.buscaSalas()
        let vrSemestres = self.buscaSemestre()
        let vrCursos = self.buscaCurso()
        let vrSemestreletivo = self.buscaSemestreletivo()
        
        var mensagem: String = "mensagem aquis"
        
        //salva no banco de acordo com a ordem, percorrendo  a lista de retorno
        //se for sincronia, lista os dados do banco e vai comparar com o ID
        //se nao for apenas salva
        if(!sincronia){
            //salvamento aqui
            for uni in vrUnidades{
                unidadeC.salvar(obj: uni)
            }
            for pre in vrPredios{
                predioC.salvar(obj: pre)
            }
            for sal in vrSalas{
                salaC.salvar(obj: sal)
            }
            for sem in vrSemestres{
                semestreC.salvar(obj: sem)
            }
            for cur in vrCursos{
                cursoC.salvar(obj: cur)
            }
            for semlet in vrSemestreletivo{
                semestreLetivoC.salvar(obj: semlet)
            }
            mensagem = "Dados baixados com sucesso!"
        }
        else{
            //atualização aqui
            //atualiza tambem as ofertas e as alocações
            buscarOfertas()
            for uni in vrUnidades{
                unidadeC.atualizar(obj: uni)
            }
            for pre in vrPredios{
                predioC.atualizar(obj: pre)
            }
            for sal in vrSalas{
                salaC.atualizar(obj: sal)
            }
            for sem in vrSemestres{
                semestreC.atualizar(obj: sem)
            }
            for cur in vrCursos{
                cursoC.atualizar(obj: cur)
            }
            for semlet in vrSemestreletivo{
                semestreLetivoC.atualizar(obj: semlet)
            }
            //ofertas
            for ofe in ofertas{
                ofertaC.atualizar(obj: ofe)
            }
            for aloc in alocacoes {
                alocacaoC.atualizar(obj: aloc)
            }
            
            mensagem = "Dados sincronizados com sucesso!"
        }
        return mensagem
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
                        let lat = json["latitude"] as! NSNumber
                        let lon = json["longitude"] as! NSNumber
                        unidade.latitude = lat.floatValue
                        unidade.longitude = lon.floatValue
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
    
    //busca os cursos
    func buscarOfertas()
    {
        //lista todas as alocacoes (e consequentemente as ofertas) já existentes
        let alocacoesAnteriores = alocacaoC.listar()
        let url = URL(string: enderecos[6])!
        self.alocacoes.removeAll()
        self.ofertas.removeAll()
        for aloc in alocacoesAnteriores {
            var terminou = false
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postData = "hash=\(chave.chave)&idalocacao=\(aloc.id)".data(using: .utf8)
            request.httpBody = postData
            // execute the datatask and validate the result
            let session = URLSession.shared
            let task = session.dataTask(with: request) {
                (data, response, error) in
                if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] ) {
                    //For getting customer_id try like this
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
                                oferta.periodo = "Regularização/Oferta Especial"
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
            }
            task.resume()
            while(!terminou){}
        }
    }
    
}
