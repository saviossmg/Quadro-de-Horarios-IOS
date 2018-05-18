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
        
    }
    
    //Consulta horarios com base em parametros
    @IBAction func consultarHorario(_ sender: UIBarButtonItem) {
    }
    
    //recarrega a lista de acordo com os dados do banco
    @IBAction func recarregarLista(_ sender: UIBarButtonItem) {
    }
    
    //sincroniza os dados existentes com o web service
    @IBAction func sincronizarDados(_ sender: UIBarButtonItem) {
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
    
    //Implementacao do metodo chamado para a troca de tela
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "carregarofertas"){
            segue.destination as! HorarioConsultaVC
        }
        else
        if(segue.identifier == "detalharoferta"){
            
        }
    }*/
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vrAlocacoes.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}
