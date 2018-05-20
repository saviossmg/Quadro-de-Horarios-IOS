//
//  AlocacaoSalaCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 10/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class AlocacaoSalaCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var alocacao = AlocacaoSalaM()
    var alocacoes: [AlocacaoSalaM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<AlocacaoSala>?
    let findSemestre = SemestreLetivoCD()
    let findSala = SalaCD()
    let findOferta = OfertaCD()
    
    let findCurso = CursoCD()
    
    func listar()->[AlocacaoSalaM]{
        //zera a lista
        alocacoes = []
        let listar:NSFetchRequest<AlocacaoSala> = AlocacaoSala.fetchRequest()
        //adiciona a ordem
        let ordenaById = NSSortDescriptor(key: "id", ascending: true)
        listar.sortDescriptors = [ordenaById]
        resultManager = NSFetchedResultsController(fetchRequest: listar, managedObjectContext: ctx.contexto, sectionNameKeyPath: nil, cacheName: nil)
        resultManager?.delegate = self
        //result menager faz a consulta
        do {
            try resultManager?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        var total = 0
        //verifica se vem realmente um inteiro
        if let contador = resultManager?.fetchedObjects?.count {
            total = contador
        }
        //se vierem registros então ele vai fazer preencher o objeto e retornar a lista preenchida
        if(total > 0){
            //faz o laço
            for aloc in (resultManager?.fetchedObjects)!{
                let aux = AlocacaoSalaM()
                aux.id = aloc.id
                aux.idoferta = aloc.idoferta
                aux.idsala = aloc.idsala
                aux.idsemestre = aloc.idsemestre
                //objetos
                aux.oferta = findOferta.findById(id: aloc.idoferta)
                aux.oferta.curso = findCurso.findById(id: aux.oferta.idcurso)
                aux.sala = findSala.findById(id: aloc.idsala)
                aux.semestre = findSemestre.findById(id: aloc.idsemestre)
                alocacoes.append(aux)
            }
        }
        return alocacoes
    }
    
    //salva um registro
    func salvar(obj: AlocacaoSalaM){
        let aux = AlocacaoSala(context: ctx.contexto)
        aux.id = obj.id
        aux.idoferta = obj.idoferta
        aux.idsemestre = obj.idsemestre
        aux.idsala = obj.idsala
        aux.oferta = findOferta.findByIdCD(id: obj.idoferta)
        aux.semestre = findSemestre.findByIdCD(id: obj.idsemestre)
        aux.sala = findSala.findByIdCD(id: obj.idsala)
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func atualizar(obj: AlocacaoSalaM){
         
    }
    
    //busca um registro pelo ID
    func findById(id: Int32)->AlocacaoSalaM{
        alocacao = AlocacaoSalaM()
        let listar:NSFetchRequest<AlocacaoSala> = AlocacaoSala.fetchRequest()
        
        //adiciona a ordem
        let ordenaById = NSSortDescriptor(key: "id", ascending: true)
        listar.sortDescriptors = [ordenaById]
        
        resultManager = NSFetchedResultsController(fetchRequest: listar, managedObjectContext: ctx.contexto, sectionNameKeyPath: nil, cacheName: nil)
        resultManager?.delegate = self
        
        //result menager faz a consulta
        do {
            try resultManager?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        var total = 0
        //verifica se vem realmente um inteiro
        if let contador = resultManager?.fetchedObjects?.count {
            total = contador
        }
        //se vierem registros então ele vai fazer preencher o objeto e retornar a lista preenchida
        if(total > 0){
            //faz o laço para verificar se objeto está corredo
            for aloc in (resultManager?.fetchedObjects)!{
                if aloc.id == id{
                    alocacao.id = id
                    alocacao.idoferta = aloc.idoferta
                    alocacao.idsala = aloc.idsala
                    alocacao.idsemestre = aloc.idsemestre
                    //alocacao.oferta = findOferta.
                    alocacao.sala = findSala.findById(id: aloc.idsala)
                    alocacao.semestre = findSemestre.findById(id: aloc.idsemestre)
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return alocacao
    }
    
}
