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
        endereco.selectedRow(inComponent: 0)
    }
    
    //Função que irá gerar
    @IBAction func gerarRota(_ sender: Any) {
        let unidade = unidades[indice]
        mapa.removeAnnotation(annotation)
        
        //let sourceLocation = CLLocationCoordinate2D(latitude: localAtual.latitude, longitude: localAtual.longitude)
        let sourceLocation = CLLocationCoordinate2D(latitude: -10.243971, longitude: -48.327583)
        let destinationLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(unidade.latitude!), longitude: CLLocationDegrees(unidade.longitude!))
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Meu local atual"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = unidade.nome
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapa.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
   
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapa.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapa.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 6
        
        return renderer
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
