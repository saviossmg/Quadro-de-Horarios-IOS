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
                    noticia.id = json["id"] as! Int
                    noticia.autor = json["autor"] as! String
                    noticia.chapeu = json["chapeu"] as! String
                    noticia.dataAtualizacao = json["dataAtualizacao"] as! String
                    noticia.dataCriacao = json["dataCriacao"] as! String
                    noticia.dataPublicacao = json["dataPublicacao"] as! String
                    noticia.palavrasChave = json["palavrasChave"] as! String
                    noticia.subTitulo = json["subTitulo"] as! String
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
    
}
