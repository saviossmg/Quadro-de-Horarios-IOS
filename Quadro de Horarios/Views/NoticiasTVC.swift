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
    var vrNoticia: [NoticiaM]!
    var ofset:Int = 0
    var noticiaC = NoticiaC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vrNoticia = noticiaC.buscaDados(ofset: ofset)
        self.ofset += 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //carrega as celulas
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let celula = tableView.dequeueReusableCell(withIdentifier: "noticiacel") as! NoticiaTVC
        celula.titulo.text = vrNoticia[indexPath.row].titulo
        celula.subtitulo.text = vrNoticia[indexPath.row].subTitulo
        return celula
    }
    
    //Metodos de delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        if(velocity.y>0){
            NSLog("dragging Up");
        }else{
            NSLog("dragging Down");
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            print(" you reached end of the table")
        }
    }
    

}
