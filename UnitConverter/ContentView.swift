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
import Foundation

struct ContentView: View {
    @State private var initialInputShown: String = ""
    func save() {
        inputValue = Double(initialInputShown)!
    }
    
    
    @State private var inputValue: Double = 32.0
    
    @State private var inputUnit: Dimension = UnitTemperature.fahrenheit
    @State private var outputUnit: Dimension = UnitTemperature.celsius
    
    @State private var selectedUnits = 0
    
    @FocusState private var inputIsFocused: Bool
    
    let conversionTypes = ["Temperature", "Length", "Time", "Volume"] // to choose from in the first section
    
    // call those by writing units[0][2] ->
    var units: [[Dimension]] {
        let tempUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
        let lengthUnits: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
        let timeUnits: [UnitDuration] = [.seconds, .minutes, .hours]
        let volumeUnits: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]
        
        return [
            tempUnits,
            lengthUnits,
            timeUnits,
            volumeUnits,
        ]
    }
    
    let formatter: MeasurementFormatter
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
        formatter.numberFormatter.zeroSymbol = ""
    }
    
    var result: String {
        let outputMeasurement = Measurement(value: inputValue, unit: inputUnit).converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Choose the Measurement you want to convert, e.g. Temperature or Length
                Section {
                    Picker("Conversion", selection: $selectedUnits) {
                                        ForEach(0..<conversionTypes.count, id: \.self) {
                                            Text(conversionTypes[$0])
                                        }
                                    }
                    .pickerStyle(.segmented)
                }
                
                // Enter the amount you want to convert
                Section {
                    HStack {
                        TextField("0,00", value: $inputValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                        
                        unitPicker(title: "", selection: $inputUnit)
                    }
                }
                    
                // Showing the result and the picker for the the output value
                Section {
                    HStack {
                        Text("\(result)")
                        //Text("\(formatter.string(from: outputUnit))")
                        unitPicker(title: "", selection: $outputUnit)
                    }
                } header: {
                     Text("is exactly")
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) {
                inputUnit = units[selectedUnits][0]
                outputUnit = units[selectedUnits][1]
            }
        }
    }
    
    private func unitPicker(title: String, selection: Binding<Dimension>) -> some View {
        Picker(title, selection: selection) {
            ForEach(units[selectedUnits], id: \.self) {
                Text(formatter.string(from: $0).capitalized)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    ContentView()
}


// Working personal solution just for temperatures:

/*
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
     
     // Custom formatter to show only two places after the dot and not showing anything when 0 is chosen
     private let quantityFormatter: NumberFormatter = {
             let formatter = NumberFormatter()
             formatter.locale = Locale.current
             formatter.numberStyle = .decimal
             formatter.minimumFractionDigits = 0
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
                             .focused($inputIsFocused)
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
             .toolbar {
                 if inputIsFocused {
                     Button("Done") {
                         inputIsFocused = false
                     }
                 }
             }
         }
     }
 }

 */
