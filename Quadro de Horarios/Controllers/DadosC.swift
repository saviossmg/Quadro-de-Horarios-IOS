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
    var unidades = [UnidadeMod]()
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
    
    func buscaUnidade()->[UnidadeMod]
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
                if let data = userObject!["data"] as? [[String: Any]] {
                    for jsonDict in data {
                        let json = jsonDict as NSDictionary
                        let unidade = UnidadeMod()
                        //aqui que aponta o erro
                        unidade.id = (json["id"] as! Int32)
                        unidade.nome = (json["nome"] as! String)
                        print(unidade.nome)
                        
                    }
                }
            }
        }.resume()
        
        //retorna no final
        return unidades
    }
    
    /*
    func buscaUnidade()->[UnidadeM]
    {
        do
        {
            //Baixa os dados da Web
            let caminho = URL(string: enderecos[0])
            let dados = try Data(contentsOf: caminho!)
            
            if (dados.count == 0)
            {
                return unidades
            }
            
            //Realiza o parsing dos dados
            let arrayUnidades = try JSONSerialization.jsonObject(with: dados, options: .mutableContainers) as? Array<Any>
            
            if let vetorUnidades = arrayUnidades
            {
                for json in vetorUnidades
                {
                    let json = json as! NSDictionary
                    let unidade = Unidade()
                    
                    //insere no array
                    print(json)
                    /*
                    unidade.id = (json["data"]["autor"] as! String)
                    noticia.chapeu = json["chapeu"] as! String
                    
                    if(json["dataAtualizacao"] is NSArray){ noticia.dataAtualizacao = "-" }
                    else{ noticia.dataAtualizacao = "Atualizada em \(formataData(param: json["dataAtualizacao"] as! String))" }
                    
                    noticia.dataCriacao = "Criada em \(formataData(param: json["dataCriacao"] as! String))"
                    noticia.dataPublicacao = "Publicada em \(formataData(param: json["dataPublicacao"] as! String))"
                    if(json["palavrasChave"] is NSArray){ noticia.palavrasChave = "-" }
                    else{ noticia.palavrasChave = json["palavrasChave"] as! String }
                    
                    if(json["subTitulo"] is NSArray){  noticia.subTitulo = "-" }
                    else { noticia.subTitulo = json["subTitulo"] as! String }
                    
                    noticia.texto = json["texto"] as! String
                    noticia.titulo = json["titulo"] as! String
                    
                    noticias.append(noticia)
                    */
                }
            }
        }
        catch
        {}
        
        return unidades
        
    }
 */
    
    /*
    func data_request(_ url:String)
    {
        let url:NSURL = NSURL(string: url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        let paramString = "data=test"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            }
        }
    }
    */
    
    
    func salvarBanco(){
        
    }
    
}
