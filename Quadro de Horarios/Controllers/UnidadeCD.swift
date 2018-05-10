//
//  UnidadeCD.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 05/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class UnidadeCD: NSObject, NSFetchedResultsControllerDelegate
{
    
    //objetos necessários
    var ctx = ContextoCD()
    var unidade = UnidadeM()
    var unidades: [UnidadeM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<Unidade>?

    //listagem geral que retornará todos os dados
    func listar()->[UnidadeM]{
        //aqui
        unidades = []
        let listar:NSFetchRequest<Unidade> = Unidade.fetchRequest()
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
            for uni in (resultManager?.fetchedObjects)!{
                let aux = UnidadeM()
                aux.id = uni.id
                aux.nome = uni.nome
                aux.endereco = uni.endereco
                aux.cep = uni.cep
                aux.latitude = uni.latitude
                aux.longitude = uni.longitude
                unidades.append(aux)
            }
        }
        //retorna o array
        return unidades
        
    }
    
    //salva um registro
    func salvar(obj: UnidadeM){
        let aux = Unidade(context: ctx.contexto)
        aux.id = obj.id
        aux.nome = obj.nome
        aux.endereco = obj.endereco
        aux.cep = obj.cep
        aux.latitude = obj.latitude
        aux.longitude = obj.longitude
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
    func findById(id: Int32)->UnidadeM{
        unidade = UnidadeM()
        let listar:NSFetchRequest<Unidade> = Unidade.fetchRequest()
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
            for uni in (resultManager?.fetchedObjects)!{
                if uni.id == id{
                    unidade.id = id
                    unidade.nome = uni.nome
                    unidade.endereco = uni.endereco
                    unidade.cep = uni.cep
                    unidade.latitude = uni.latitude
                    unidade.longitude = uni.longitude
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return unidade
    }
    
    func findByIdCD(id: Int32)->Unidade{
        var auxUnidadeCD = Unidade()
        let listar:NSFetchRequest<Unidade> = Unidade.fetchRequest()
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
            for uni in (resultManager?.fetchedObjects)!{
                if uni.id == id{
                    auxUnidadeCD = uni
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return auxUnidadeCD
    }
}
