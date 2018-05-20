//
//  SemestreCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 10/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class SemestreCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var semestre = SemestreM()
    var semestres: [SemestreM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<Semestre>?
    var findPredio = PredioCD()
    
    //listagem geral que retornará todos os dados
    func listar()->[SemestreM]{
        //zera a lista
        semestres = []
        let listar:NSFetchRequest<Semestre> = Semestre.fetchRequest()
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
            for sem in (resultManager?.fetchedObjects)!{
                let aux = SemestreM()
                aux.id = sem.id
                aux.descricao = sem.descricao
                semestres.append(aux)
            }
        }
        return semestres
    }
    
    //salva um registro
    func salvar(obj: SemestreM){
        let aux = Semestre(context: ctx.contexto)
        aux.id = obj.id
        aux.descricao = obj.descricao
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
    func findById(id: Int32)->SemestreM{
        semestre = SemestreM()
        let listar:NSFetchRequest<Semestre> = Semestre.fetchRequest()
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
            for sem in (resultManager?.fetchedObjects)!{
                if sem.id == id{
                    semestre.id = id
                    semestre.descricao = sem.descricao
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return semestre
    }
    
    func findByIdCD(id: Int32)->Semestre{
        var auxSemetreCD = Semestre(context: ctx.contexto)
        let listar:NSFetchRequest<Semestre> = Semestre.fetchRequest()
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
            for sem in (resultManager?.fetchedObjects)!{
                if sem.id == id{
                    auxSemetreCD = sem
                }
            }
        }
        return auxSemetreCD
    }
}
