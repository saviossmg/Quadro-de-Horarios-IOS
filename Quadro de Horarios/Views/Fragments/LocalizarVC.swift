//
//  LocalizarVC.swift
//  Quadro de Horarios
//
//  Created by Savio Martins Valentim on 21/05/18.
//  Copyright © 2018 UNITINS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocalizarVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var endereco: UIPickerView!
    @IBOutlet var mapa: MKMapView!
    @IBOutlet var btnGerarrota: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var localAtual: CLLocationCoordinate2D!
    let annotation = MKPointAnnotation()

    //classe core data
    let findUnidade = UnidadeCD()
    
    //classes modelo
    var unidades = [UnidadeM]()
    
    //indices
    var indice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endereco.delegate = self
        mapa.delegate = self
        
        endereco.dataSource = self

        carregaUnidades()
        
        //localizador
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20

    }
    
    override func viewWillAppear(_ animated: Bool) {
        endereco.selectedRow(inComponent: indice)
        if unidades.count == 1{
            carregaUnidades()
            endereco.reloadAllComponents()
        }
    }
    
    //Função que irá gerar a rota
    @IBAction func gerarRota(_ sender: Any) {
        let unidade = unidades[indice]
        //monta a url com as coordenadas de destino e ponto de saida
        let url = URL(string: "http://maps.apple.com/?saddr=\(unidade.latitude!),\(unidade.longitude!)&daddr=\(Float(localAtual.latitude)),\(Float(localAtual.longitude))&dirflg=d")!
    
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else
        {
            UIApplication.shared.openURL(url)
        }
 
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for localatual in locations {
            localAtual = localatual.coordinate
        }
    }
    
    func numberOfComponents (in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //retorna o contador do picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case endereco:
                return unidades.count
            default:
                return 0
        }
    }
    
    //retorna a descricao
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case endereco:
                let unidSelec = unidades[row]
                
                let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(unidSelec.latitude!), longitude: CLLocationDegrees(unidSelec.longitude!))
                var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
                if(unidSelec.id == 0){
                    region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 150, longitudeDelta: 150))
                    mapa.removeAnnotation(annotation)
                    btnGerarrota.isEnabled = false
                }
                else{
                    annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(unidSelec.latitude!), longitude: CLLocationDegrees(unidSelec.longitude!))
                    annotation.title = unidSelec.nome
                    region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    mapa.addAnnotation(annotation)
                    btnGerarrota.isEnabled = true
                }
                mapa.setRegion(region, animated: true)
                return unidades[row].nome
            default:
                return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
            case endereco:
                self.indice = row
            default:
                print("h")
        }
    }
    
    func carregaUnidades(){
        unidades.removeAll()
        let aux = UnidadeM()
        aux.id = 0
        aux.nome = "Selecione aqui o CÂMPUS."
        aux.latitude = 0
        aux.longitude = 0
        unidades.append(aux)
        let lista = findUnidade.listar()
        for load in lista
        {
            if load.nome != nil {
                unidades.append(load)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    

}
