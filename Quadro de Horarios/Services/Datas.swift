//
//  Datas.swift
//  Quadro de Horarios
//
//  Created by LabMacMini06 on 06/04/2018.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import Foundation

class Datas{
    
    //converte DATE para STRING
    func getData2String(param: Date)->String
    {
        var dateString: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" //Your New Date format as per requirement change it own
        dateString = dateFormatter.string(from: param) //pass Date here
        return dateString
    }
    
    
    //converte STRING para DATE
    func getString2Data(param: String)->Date
    {
        var data: Date!
        //codigo aqui
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy hh:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        data = dateFormatter.date(from: param) //according to date format your date string
        return data
    }
    
    
    
}
