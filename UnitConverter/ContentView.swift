//
//  ContentView.swift
//  UnitConverter
//
//  Created by Marcus Benoit on 09.03.24.
//

/*
 Celsius, Fahrenheit or Kelvin
 
 
 */

import SwiftUI

struct ContentView: View {
    @State private var input: Double = 0
    @State private var output: Double = 0
    
    enum Units: String, CaseIterable, Identifiable {
        case Celsius, Fahrenheit, Kelvin
        var id: Self { self }
    }
    
    @State private var selectedInputUnit: Units = .Celsius
    @State private var selectedOutputUnit: Units = .Fahrenheit

    
    @FocusState private var inputIsFocused: Bool
    
//    switch Convert {
//    case CelsiusToFahrenheit:
//        
//    case CelsiusToKelvin:
//        
//    case FahrenheitToCelsius:
//        
//    case FahrenheitToKelvin:
//        
//    case KelvinToCelsius:
//        
//    case KelvinToFahrenheit:
//        
//    default:
//}
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack{
                        TextField("Input Unit", value: $input, format: .number)
                        Picker("", selection: $selectedInputUnit) {
                            ForEach(Units.allCases) { unit in
                                Text(unit.rawValue.capitalized)
                            }
                        }
                    }
                }
                
                Section {
                    
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}


