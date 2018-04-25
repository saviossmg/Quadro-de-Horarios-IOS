//
//  DadosC.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 17/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation

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
    
    //busca as unidades
    func buscaUnidade()->[UnidadeM]
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
                        let unidade = UnidadeM()
                        unidade.id = (json["id"] as! Int32)
                        unidade.nome = (json["nome"] as! String)
                        unidade.endereco = (json["endereco"] as! String)
                        unidade.cep = (json["cep"] as! Int32)
                        unidade.latitude = (json["latitude"] as! Float)
                        unidade.longitude = (json["nome"] as! Float)
                        self.unidades.append(unidade)
                    }
                }
            }
        }.resume()
        print("unidades \(self.unidades.count)")
        //retorna no final
        return unidades
    }
    
    //busca os predios
    func buscaPredio()->[PredioM]
    {
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
            }.resume()
        print("predios \(self.predios.count)")
        //retorna no final
        return predios
    }
    
    //busca os predios
    func buscaSalas()->[SalaM]
    {
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
                        sala.tipo = (json["string"] as! String)
                        sala.ativo = (json["ativo"] as! Bool)
                        self.salas.append(sala)
                    }
                }
            }
            }.resume()
        print("salas \(self.salas.count)")
        //retorna no final
        return salas
    }
    
    func salvarBanco(){
        
    }
    
}
