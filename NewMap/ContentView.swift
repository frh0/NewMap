//
//  ContentView.swift
//  NewMap
//
//  Created by frh alshaalan on 13/05/2023.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [MKPointAnnotation]
    
    var locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Request user location permission
        locationManager.requestWhenInUseAuthorization()
        
        // Show user location on map
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
   
}

struct ContentView: View {
    @State  var centerCoordinate = CLLocationCoordinate2D()
    @State  var locations = [MKPointAnnotation]()
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, locations: $locations)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height:32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Add new pin at centerCoordinate
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title2)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
