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
    
    
    func listarParaterizado()->[AlocacaoSalaM]{
        //zera a lista
        alocacoes.removeAll()
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
            //calula os parametros com base no storedproprietds
            let param = StoreManager.retornaPreferencias()
            var contParametros = 0
            
            if(param.semestre != 0){
                contParametros += 1
            }
            if(param.dia != 0){
                contParametros += 1
            }
            if(param.periodo != -1){
                contParametros += 1
            }
            if(param.sala != 0){
                contParametros += 1
            }
            if(param.curso != 0){
                contParametros += 1
            }
            if(param.turno != 0){
                contParametros += 1
            }
            //estaticosv
            
            var auxturno = ""
            var auxdia = ""
            var auxperiodo = ""
            
            //dias
            if(param.dia==13) {auxdia = "Segunda-Feira"}
            if(param.dia==14) {auxdia = "Terça-Feira"}
            if(param.dia==15) {auxdia = "Quarta-Feira"}
            if(param.dia==16) {auxdia = "Quinta-Feira"}
            if(param.dia==17) {auxdia = "Sexta-Feira"}
            if(param.dia==18) {auxdia = "Sábado"}
            
            //turnos
            if(param.turno==9) {auxturno = "Matutino"}
            if(param.turno==10) {auxturno = "Vespertino"}
            if(param.turno==11) {auxturno = "Noturno"}
            
            //periodos
            if(param.periodo==0) {auxperiodo = "Regularização/Especial"}
            if(param.periodo==1) {auxperiodo = "1º Período"}
            if(param.periodo==2) {auxperiodo = "2º Período"}
            if(param.periodo==3) {auxperiodo = "3º Período"}
            if(param.periodo==4) {auxperiodo = "4º Período"}
            if(param.periodo==5) {auxperiodo = "5º Período"}
            if(param.periodo==6) {auxperiodo = "6º Período"}
            if(param.periodo==7) {auxperiodo = "7º Período"}
            if(param.periodo==8) {auxperiodo = "8º Período"}
            if(param.periodo==9) {auxperiodo = "9º Período"}
            if(param.periodo==10) {auxperiodo = "10º Período"}
            
            //faz o laço
            for aloc in (resultManager?.fetchedObjects)!{
                var auxcont = 0
                if aloc.semestre?.semestre?.id == param.semestre { auxcont += 1 } //semestre
                if aloc.oferta?.diasemana == auxdia { auxcont += 1 } //diasemana
                if aloc.oferta?.periodo == auxperiodo { auxcont += 1 } // periodo
                if aloc.sala?.id == param.sala { auxcont += 1 } //dia
                if aloc.oferta?.turno == auxturno { auxcont += 1 } //sala
                if aloc.oferta?.idcurso == param.curso { auxcont += 1  } //curso
                //adiciona só se  for igual
                if auxcont == contParametros {
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
        let aux = findByIdCD(id: obj.id)
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
    
    func findByIdCD(id: Int32)->AlocacaoSala{
        var auxAlocCD = AlocacaoSala(context: ctx.contexto)
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
                    auxAlocCD = aloc
                }
            }
        }
        //vai verificar se o objeto selecionado está na lsita e retornará ele
        return auxAlocCD
    }
    
}
