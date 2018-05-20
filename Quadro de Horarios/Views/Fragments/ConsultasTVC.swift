//
//  ConsultasTVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 26/03/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit

class ConsultasTVC: UITableViewController {

    var vrUnidades: [UnidadeM] = []
    var vrPredios: [PredioM] = []
    var vrSalas: [SalaM] = []
    var vrSemestres: [SemestreM] = []
    var vrSemestreLetivos: [SemestreLetivoM] = []
    var vrCursos: [CursoM] = []
    
    var vrAlocacoes: [AlocacaoSalaM] = []
    
    //controlador do buscador
    let dadosC = DadosC()
    
    //controlador do banco
    let alocaC = AlocacaoSalaCD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vrAlocacoes = alocaC.listar()
        //recarrega a lista caso tenham elementos
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //verifica se os dados estão vazios
        let existe = dadosC.verificaDados()        
        //carrega tudo se não tiver nada
        if(!existe){
            let ret = dadosC.buscarDados(sincronia: false)
            let alert = UIAlertController(title: "", message: "\(ret)", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //recarrega a lista de acordo com os dados do banco
    @IBAction func recarregarLista(_ sender: UIBarButtonItem) {
    }
    
    //sincroniza os dados existentes com o web service
    @IBAction func sincronizarDados(_ sender: UIBarButtonItem) {
    }
    
    func carregaAlocacaos(){
        
    }
    
    //Implementacao do metodo chamado para a troca de tela
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
   {
        if(segue.identifier == "carregarofertas"){
            segue.destination as! HorarioConsultaVC
        }
        else
        if(segue.identifier == "detalharoferta"){
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let telaOferta =  segue.destination as! HorarioDetalhesVC
                telaOferta.disciplina = vrAlocacoes[indexPath.row].oferta.disciplina
                /*
                telaOferta.
                telaNoticia.txtAutor = vrNoticia[indexPath.row].autor
                telaNoticia.txtCriada = vrNoticia[indexPath.row].dataCriacao
                telaNoticia.txtTexto = vrNoticia[indexPath.row].texto
                */
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
        return vrAlocacoes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }

    //celulas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "alocacaocel") as! AlocacaoTVC
        celula.dia.text = vrAlocacoes[indexPath.row].oferta.diasemana
        celula.disciplina.text = vrAlocacoes[indexPath.row].oferta.disciplina
        print("Linha \(indexPath.row)")
        print("\(vrAlocacoes[indexPath.row].oferta.curso)")
        print("\(vrAlocacoes[indexPath.row].oferta.periodo)")
        //celula.curso.text = vrAlocacoes[indexPath.row].oferta.curso.nome
        celula.sala.text = vrAlocacoes[indexPath.row].sala.nome
        return celula
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        vrAlocacoes = alocaC.listar()
        tableView.reloadData()
        //Trata os retornos dessa tela
        /*
        if let fonte = segue.source as? HorarioConsultaVC {
            var msg = "Lista atualizada de acordo com os parâmetross selecionados!"
            let alert = UIAlertController(title: "Sucesso", message: "\(msg)", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)           
            
        }
        */
        
    }

}
