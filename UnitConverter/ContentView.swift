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
    
    enum Units: String, CaseIterable, Identifiable {
        case Celsius, Fahrenheit, Kelvin
        var id: Self { self }
    }
    
    @State private var selectedInputUnit: Units = .Celsius
    @State private var selectedOutputUnit: Units = .Fahrenheit
    
    let formatter = NumberFormatter()
    
    var output: Double {
        let input = input
        let inputUnit = selectedInputUnit
        let outputUnit = selectedOutputUnit
        
        if inputUnit == .Celsius && outputUnit == .Fahrenheit {
            return (input * 1.8) + 32
        } else if inputUnit == .Celsius && outputUnit == .Kelvin {
            return input + 273.15
        } else if inputUnit == .Fahrenheit && outputUnit == .Celsius {
            return (input - 32) * 5/9
        } else if inputUnit == .Fahrenheit && outputUnit == .Kelvin {
            return (input + 459.67) * 5/9
        } else if inputUnit == .Kelvin && outputUnit == .Celsius {
            return input - 273.15
        } else if inputUnit == .Kelvin && outputUnit == .Fahrenheit {
            return 1.8 * (input - 273) + 32
        } else if inputUnit == outputUnit {
            return input
        }
        
        return 0
    }

    @FocusState private var inputIsFocused: Bool
    
    // Inserted
    private let quantityFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            formatter.zeroSymbol = ""
            return formatter
    }()
    
    @State private var quantity = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack{
                        TextField("0,00", value: $input, formatter: quantityFormatter)
                            .keyboardType(.decimalPad)
                        Picker("", selection: $selectedInputUnit) {
                            ForEach(Units.allCases) { unit in
                                Text(unit.rawValue.capitalized)
                            }
                        }
                    }
                }
                .keyboardType(.numberPad)
                
                Section("Convert to") {
                    Picker("Convert to", selection: $selectedOutputUnit) {
                        ForEach(Units.allCases) { unit in
                            Text(unit.rawValue.capitalized)}
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("\(input) \(selectedInputUnit) is exactly") {
                    HStack{
                        Text("\(output, specifier: "%.2f")") // specifier rounds to only two decimal places
                        Text("\(selectedOutputUnit)")
                    }
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}


