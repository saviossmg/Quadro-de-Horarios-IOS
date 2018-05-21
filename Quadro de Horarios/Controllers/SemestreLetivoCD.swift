//
//  SemestreLetivoCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 10/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class SemestreLetivoCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var semestreletivo = SemestreLetivoM()
    var semestresletivos: [SemestreLetivoM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<SemestreLetivo>?
    var findCurso = CursoCD()
    var findSemestre = SemestreCD()
    
    //listagem geral que retornará todos os dados
    func listar()->[SemestreLetivoM]{
        //zera a lista
        semestresletivos = []
        let listar:NSFetchRequest<SemestreLetivo> = SemestreLetivo.fetchRequest()
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
            for semlet in (resultManager?.fetchedObjects)!{
                let aux = SemestreLetivoM()
                aux.id = semlet.id
                aux.idcurso = semlet.idcurso
                aux.idsemestre = semlet.idsemestre
                //obetos relacionados
                aux.curso = findCurso.findById(id: semlet.idcurso)
                aux.semestre = findSemestre.findById(id: semlet.idsemestre)
                semestresletivos.append(aux)
            }
        }
        return semestresletivos
    }
    
    //salva um registro
    func salvar(obj: SemestreLetivoM){
        let aux = SemestreLetivo(context: ctx.contexto)
        aux.id = obj.id
        aux.idcurso = obj.idcurso
        aux.idsemestre = obj.idsemestre
        //objetos relacionados
        aux.curso = findCurso.findByIdCD(id: obj.idcurso)
        aux.semestre = findSemestre.findByIdCD(id: obj.idsemestre)
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //atualiza um registro
    func atualizar(obj: SemestreLetivoM){
        let aux = findByIdCD(id: obj.id)
        aux.idcurso = obj.idcurso
        aux.idsemestre = obj.idsemestre
        //objetos relacionados
        aux.curso = findCurso.findByIdCD(id: obj.idcurso)
        aux.semestre = findSemestre.findByIdCD(id: obj.idsemestre)
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //busca um registro pelo ID
    func findById(id: Int32)->SemestreLetivoM{
        semestreletivo = SemestreLetivoM()
        let listar:NSFetchRequest<SemestreLetivo> = SemestreLetivo.fetchRequest()
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
            for semlet in (resultManager?.fetchedObjects)!{
                if semlet.id == id{
                    semestreletivo.id = id
                    semestreletivo.idcurso = semlet.idcurso
                    semestreletivo.idsemestre = semlet.idsemestre
                    //objetos relacionados
                    semestreletivo.curso = findCurso.findById(id: semlet.idcurso)
                    semestreletivo.semestre = findSemestre.findById(id: semlet.idsemestre)
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return semestreletivo
    }
    
    func findByIdCD(id: Int32)->SemestreLetivo{
        var auxSemetreLetCD = SemestreLetivo(context: ctx.contexto)
        let listar:NSFetchRequest<SemestreLetivo> = SemestreLetivo.fetchRequest()
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
            for semlet in (resultManager?.fetchedObjects)!{
                if semlet.id == id{
                    auxSemetreLetCD = semlet
                }
            }
        }
        return auxSemetreLetCD
    }
 
}
