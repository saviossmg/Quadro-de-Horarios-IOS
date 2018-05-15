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
    let cc = CriptografiaM()
    
    //controladores do banco com funcoes do core data
    let ofertaC =  OfertaCD()
    let alocacaoC = AlocacaoSalaCD()
    
    //lista de endereços
    let endereco = "https://alocacaosalas.unitins.br/getAlocacao.php"
    
    var parametros: [String: String] = ["hash": "tt"]

    
    
    
}
