//
//  UnidadeCD.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 03/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation
import CoreData

class UnidadeCD: NSManagedObject
{
    @NSManaged var id:Int32
    @NSManaged var nome:String
    @NSManaged var endereco:String
    @NSManaged var cep:Int32
    @NSManaged var latitude:Float
    @NSManaged var longitude:Float
    @NSManaged var predios: Set<Predio>
    
    //listagem -todos
    class func getAll(moc:NSManagedObjectContext)->[Unidade]?
    {
        let request = NSFetchRequest<Unidade>(entityName: "Unidade")
        let classificacao = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [classificacao]
        do{
            return try moc.fetch(request)
        } catch {
        }
        return nil
    }
    
    //salvar
    class func save(moc:NSManagedObjectContext, id:Int32, nome:String, endereco:String, cep:Int32, lati: Float, long: Float)->UnidadeCD?
    {
        if let novaUnidade = NSEntityDescription.insertNewObject(forEntityName: "Unidade", into: moc) as? UnidadeCD
        {
            novaUnidade.nome = nome
            novaUnidade.id = id
            novaUnidade.endereco = endereco
            novaUnidade.cep = cep
            novaUnidade.latitude = lati
            novaUnidade.longitude = long
            novaUnidade.save()            
            return novaUnidade
        }
        return nil
    }
    
    func save()
    {
        do
        {
            try managedObjectContext?.save()
        }
        catch{}
    }
    
    override var hashValue: Int
    {
        return id.hashValue
    }
    
}
