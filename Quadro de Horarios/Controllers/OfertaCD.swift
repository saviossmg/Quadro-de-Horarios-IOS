//
//  OfertaCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 10/05/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import CoreData

class OfertaCD: NSObject, NSFetchedResultsControllerDelegate
{
    //objetos necessários
    var ctx = ContextoCD()
    var oferta = OfertaM()
    var ofertas: [OfertaM] = []
    
    //utilitarios do core data
    let searchController = UISearchController(searchResultsController: nil)
    var resultManager:NSFetchedResultsController<Oferta>?
    let findCurso = CursoCD()
    
    func listar()->[OfertaM]{
        //zera a lista
        ofertas.removeAll()
        /*
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
                aux.sala = findSala.findById(id: aloc.idsala)
                aux.semestre = findSemestre.findById(id: aloc.idsemestre)
                alocacoes.append(aux)
            }
        }
 */
        return ofertas
    }
    
    //salva um registro
    func salvar(obj: OfertaM){
        let aux = Oferta(context: ctx.contexto)
        aux.id = obj.id
        aux.descricaoperiodoletivo = obj.descricaoperiodoletivo
        aux.diasemana = obj.diasemana
        aux.disciplina = obj.disciplina
        aux.horainiciala = obj.horainiciala
        aux.horainicialb = obj.horainicialb
        aux.intervaloinicio = obj.intervaloinicio
        aux.intervalofim = obj.intervalofim
        aux.horafinala = obj.horafinala
        aux.horafinalb = obj.horainicialb
        aux.nometurma = obj.nometurma
        aux.periodo = obj.periodo
        aux.professor = obj.professor
        aux.turno = obj.turno
        //
        aux.idcurso = obj.idcurso
        aux.curso = findCurso.findByIdCD(id: obj.idcurso)
        do {
            try ctx.contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func atualizar(obj: OfertaM){
        
    }
    
    //busca um registro pelo ID
    func findById(id: Int32)->OfertaM{
        oferta = OfertaM()
        let listar:NSFetchRequest<Oferta> = Oferta.fetchRequest()        
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
            for ofe in (resultManager?.fetchedObjects)!{
                if ofe.id == id{
                    oferta.id = id
                    oferta.descricaoperiodoletivo = ofe.descricaoperiodoletivo
                    oferta.diasemana = ofe.diasemana
                    oferta.disciplina = ofe.disciplina
                    oferta.horainiciala = ofe.horainiciala
                    oferta.horainicialb = ofe.horainicialb
                    oferta.intervaloinicio = ofe.intervaloinicio
                    oferta.intervalofim = ofe.intervalofim
                    oferta.horafinala = ofe.horafinala
                    oferta.horafinalb = ofe.horainicialb
                    oferta.idcurso = ofe.idcurso
                    oferta.nometurma = ofe.nometurma
                    oferta.periodo = ofe.periodo
                    oferta.professor = ofe.professor
                    oferta.turno = ofe.turno
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return oferta
    }
    
    func findByIdCD(id: Int32)->Oferta{
        var auxOfertaCD = Oferta(context: ctx.contexto)
        let listar:NSFetchRequest<Oferta> = Oferta.fetchRequest()
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
            for ofe in (resultManager?.fetchedObjects)!{
                if ofe.id == id{
                    auxOfertaCD = ofe
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return auxOfertaCD
    }
 
    
}
