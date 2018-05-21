//
//  PredioCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 08/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class PredioCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var predio = PredioM()
    var predios: [PredioM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<Predio>?
    var findUnidade = UnidadeCD()
    
    //listagem geral que retornará todos os dados
    func listar()->[PredioM]{
        //zera a lista
        predios = []
        let listar:NSFetchRequest<Predio> = Predio.fetchRequest()
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
            for pre in (resultManager?.fetchedObjects)!{
                let aux = PredioM()
                aux.id = pre.id
                aux.nome = pre.nome
                aux.pisos = pre.pisos
                aux.ativo = pre.ativo
                //referencia a outros objetos
                aux.idunidade = pre.idunidade
                aux.unidade = findUnidade.findById(id: pre.idunidade)
                predios.append(aux)
            }
        }
        return predios
        
    }
    
    //salva um registro
    func salvar(obj: PredioM){
        let aux = Predio(context: ctx.contexto)
        aux.id = obj.id
        aux.nome = obj.nome
        aux.idunidade = obj.idunidade
        aux.pisos = obj.pisos
        aux.ativo = obj.ativo
        //seta o objeto
        aux.unidade = findUnidade.findByIdCD(id: obj.idunidade)
        // como setar os objtos core data ?
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //atualiza um registro
    func atualizar(obj: PredioM){
        let aux = findByIdCD(id: obj.id)
        aux.nome = obj.nome
        aux.idunidade = obj.idunidade
        aux.pisos = obj.pisos
        aux.ativo = obj.ativo
        //seta o objeto
        aux.unidade = findUnidade.findByIdCD(id: obj.idunidade)
        do{
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //busca um registro pelo ID
    func findById(id: Int32)->PredioM{
        predio = PredioM()
        let listar:NSFetchRequest<Predio> = Predio.fetchRequest()
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
            for pre in (resultManager?.fetchedObjects)!{
                if(pre.id == id) {
                    predio.id = pre.id
                    predio.nome = pre.nome
                    predio.pisos = pre.pisos
                    predio.ativo = pre.ativo
                    //seta o objeto
                    predio.idunidade = pre.idunidade
                    predio.unidade = findUnidade.findById(id: pre.idunidade)
                }
            }
        }
        return predio
        
    }
    
    func findByIdCD(id: Int32)->Predio{
        var auxPredioCD = Predio(context: ctx.contexto)
        let listar:NSFetchRequest<Predio> = Predio.fetchRequest()
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
            for pre in (resultManager?.fetchedObjects)!{
                if pre.id == id{
                    auxPredioCD = pre
                }
            }
        }
        return auxPredioCD
    }
    
}
