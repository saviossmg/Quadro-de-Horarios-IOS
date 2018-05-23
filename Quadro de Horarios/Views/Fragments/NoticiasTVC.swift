//
//  NoticiasTVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 26/03/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit

class NoticiasTVC: UITableViewController {

    //Referencia pra o vetor de clientes vindos do servico
    var vrNoticia: [NoticiaM] = []
    var ofset:Int = 0
    var noticiaC = NoticiaC()
    var primeira = false
    var p = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(vrNoticia.isEmpty){
            let c = checaConexao()
            if c {
                carregaNoticia()
            }
        }
    }
    
    func checaConexao()->Bool{
        var conectado = false
        var parou = false
        Conexao.isInternetAvailable(webSiteToPing: nil) { (isInternetAvailable) in
            guard isInternetAvailable else {
                // Inform user for example
                let msg = "Falha de conexão.\nVerifique a conexão de seu aparelho."
                let alert = UIAlertController(title: "Atenção", message: "\(msg)", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                parou = true
                return
            }
            // Do some action if there is Internet
            conectado = true
            parou = true
            return
        }
        while !parou{}
        return conectado
    }
    
    func carregaNoticia(){
        if(self.vrNoticia.isEmpty){
            self.vrNoticia = self.noticiaC.buscaDados(ofset: self.ofset)
            self.ofset += 1
        }
        else{
            let noticia = self.noticiaC.buscaDados(ofset: self.ofset)
            self.vrNoticia.append(contentsOf: noticia)
            self.ofset += 1
        }
        self.tableView.reloadData()
        
    }
    
    //Implementacao do metodo chamado para a troca de tela
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "mostrar"){
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let telaNoticia = segue.destination as! NoticiaDetalhesVC
                telaNoticia.txtTitulo = vrNoticia[indexPath.row].titulo
                telaNoticia.txtAutor = vrNoticia[indexPath.row].autor
                telaNoticia.txtCriada = vrNoticia[indexPath.row].dataCriacao
                telaNoticia.txtTexto = vrNoticia[indexPath.row].texto
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vrNoticia.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    //carrega as celulas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let celula = tableView.dequeueReusableCell(withIdentifier: "noticiacel") as! NoticiaTVC
        celula.titulo.text = vrNoticia[indexPath.row].titulo
        celula.subtitulo.text = vrNoticia[indexPath.row].subTitulo
        celula.publicada.text = vrNoticia[indexPath.row].dataPublicacao
        celula.atualizada.text = vrNoticia[indexPath.row].dataAtualizacao
        return celula
    }
    
    //Metodos de delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        var distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (distanceFromBottom < height ) {
            let c = checaConexao()
            if c {
                carregaNoticia()
            }
        }
    }
    

}
