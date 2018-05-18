//
//  SalaCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 10/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class SalaCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var sala = SalaM()
    var salas: [SalaM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<Sala>?
    var findPredio = PredioCD()
    
    //listagem geral que retornará todos os dados
    func listar()->[SalaM]{
        //zera a lista
        salas = []
        let listar:NSFetchRequest<Sala> = Sala.fetchRequest()
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
            for sal in (resultManager?.fetchedObjects)!{
                let aux = SalaM()
                aux.id = sal.id
                aux.nome = sal.nome
                aux.piso = sal.pios
                aux.tipo = sal.tipo
                aux.ativo = sal.ativo
                //referencia a outros objetos
                aux.idpredio = sal.idpredio
                aux.predio = findPredio.findById(id: sal.idpredio)
                salas.append(aux)
            }
        }
        return salas
        
    }
    
    //salva um registro
    func salvar(obj: SalaM){
        let aux = Sala(context: ctx.contexto)
        aux.id = obj.id
        aux.nome = obj.nome
        aux.pios = obj.piso
        aux.tipo = obj.tipo
        aux.ativo = obj.ativo
        //referencia a outros objetos
        aux.idpredio = obj.idpredio
        aux.predio = findPredio.findByIdCD(id: obj.idpredio)
        
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //atualiza um registro
    func atualizar(){
        //aqui
    }
    
    //busca um registro pelo ID
    func findById(id: Int32)->SalaM{
        sala = SalaM()
        
        let listar:NSFetchRequest<Sala> = Sala.fetchRequest()
        
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
            for sal in (resultManager?.fetchedObjects)!{
                if sal.id == id{
                    sala.id = id
                    sala.nome = sal.nome
                    sala.piso = sal.pios
                    sala.tipo = sal.tipo
                    sala.ativo = sala.ativo
                    //
                    sala.predio = findPredio.findById(id: sal.idpredio)
                    sala.idpredio = sal.idpredio
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return sala
    }


 func findByIdCD(id: Int32)->Sala{
     var auxSalaCD = Sala()
    
     let listar:NSFetchRequest<Sala> = Sala.fetchRequest()
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
        for sal in (resultManager?.fetchedObjects)!{
            if sal.id == id{
                auxSalaCD = sal
            }
        }
     }
     //vai verificar se o objeto selecionado está na lsita e retornará ele
    
     return auxSalaCD
    }
}
