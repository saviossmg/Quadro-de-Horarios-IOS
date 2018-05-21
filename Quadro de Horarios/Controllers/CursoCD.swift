//
//  CursoCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 10/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class CursoCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var curso = CursoM()
    var cursos: [CursoM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<Curso>?
    var findUnidade = UnidadeCD()
    
    //listagem geral que retornará todos os dados
    func listar()->[CursoM]{
        //zera a lista
        cursos = []
        let listar:NSFetchRequest<Curso> = Curso.fetchRequest()
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
            for cur in (resultManager?.fetchedObjects)!{
                let aux = CursoM()
                aux.id = cur.id
                aux.nome = cur.nome
                aux.codCurso = cur.codcurso
                //referencia a outros objetos
                aux.idunidade = cur.idunidade
                aux.unidade = findUnidade.findById(id: cur.idunidade)
                
                cursos.append(aux)
            }
        }
        return cursos
        
    }
    
    //salva um registro
    func salvar(obj: CursoM){
        let aux = Curso(context: ctx.contexto)
        aux.id = obj.id
        aux.nome = obj.nome
        aux.codcurso = obj.codCurso
        //seta o objeto
        aux.idunidade = obj.idunidade
        aux.unidade = findUnidade.findByIdCD(id: obj.idunidade)
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //atualiza um registro
    func atualizar(obj: CursoM){
        let aux = findByIdCD(id: obj.id)
        aux.nome = obj.nome
        aux.codcurso = obj.codCurso
        //seta o objeto
        aux.idunidade = obj.idunidade
        aux.unidade = findUnidade.findByIdCD(id: obj.idunidade)
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //busca um registro pelo ID
    func findById(id: Int32)->CursoM{
        curso = CursoM()
        let listar:NSFetchRequest<Curso> = Curso.fetchRequest()
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
            for cur in (resultManager?.fetchedObjects)!{
                if(cur.id == id) {
                    curso.id = id
                    curso.nome = cur.nome
                    curso.codCurso = cur.codcurso
                    //seta o objeto
                    curso.idunidade = cur.idunidade
                    curso.unidade = findUnidade.findById(id: cur.idunidade)
                }
            }
        }
        return curso
    }
    
    func findByIdCD(id: Int32)->Curso{
        var auxCursoCD = Curso(context: ctx.contexto)
        let listar:NSFetchRequest<Curso> = Curso.fetchRequest()
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
            for cur in (resultManager?.fetchedObjects)!{
                if cur.id == id{
                    auxCursoCD = cur
                }
            }
        }
        return auxCursoCD
    }
}
