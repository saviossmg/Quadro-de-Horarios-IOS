//
//  NoticiaC.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 05/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation

class NoticiaC{
    
    var noticias = [NoticiaM]()
    
    func buscaDados(ofset: Int)->[NoticiaM]
    {
        do
        {
            //Baixa os dados da Web
            let caminho = URL(string: "https://alocacaosalas.unitins.br/getNoticia.php?offset="+String(ofset))
            let dados = try Data(contentsOf: caminho!)
            
            if (dados.count == 0)
            {
                return noticias
            }
            
            //Realiza o parsing dos dados
            let arrayNoticias = try JSONSerialization.jsonObject(with: dados, options: .mutableContainers) as? Array<Any>
            
            if let vetorNoticias = arrayNoticias
            {
                for json in vetorNoticias
                {
                    let json = json as! NSDictionary
                    let noticia = NoticiaM()
                    //insere
                    noticia.autor = "Autor(a): \(json["autor"] as! String)"
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
                }
            }
        }
        catch
        {}
        
        return noticias
    
    }
    
    //funcao para formatar a data
    func formataData(param: String)->String{
        
        let arrayParam = param.components(separatedBy: "T")
        let paramDia = arrayParam[0].components(separatedBy: "-")
        let paramHora = arrayParam[1].components(separatedBy: ":")
        let paramSeg = paramHora[2].components(separatedBy: ".")
        
        let data = "\(paramDia[2])/\(paramDia[1])/\(paramDia[0])"
        let hora = "\(paramHora[0]):\(paramHora[1]):\(paramSeg[0])"
        
        let retorno = "\(data) às \(hora)"
        
        return retorno
    }
    
    
}
