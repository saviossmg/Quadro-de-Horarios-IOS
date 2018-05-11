//
//  NoticiaDetalhesVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 03/04/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit

class NoticiaDetalhesVC: UIViewController, UIWebViewDelegate {

    //referencias visuais
    @IBOutlet var titulo: UILabel!
    @IBOutlet var autor: UILabel!
    @IBOutlet var dataCriacao: UILabel!
    @IBOutlet var conteudo: UIWebView!
    
    //variaveis de data source
    var txtTitulo:String!
    var txtAutor:String!
    var txtCriada:String!
    var txtTexto:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //seta os textos
        titulo.text = txtTitulo
        autor.text = txtAutor
        dataCriacao.text = txtCriada
        conteudo.loadHTMLString(txtTexto, baseURL: nil)
        conteudo.reload()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url, navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.openURL(url)
            return false
        }
        return true
    }


}
