//
//  ContentView.swift
//  Temperature
//
//  Created by Dom Bryan on 29/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemp = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @FocusState private var amountIsFocused: Bool
    
    let inputUnits = ["C", "F", "K"]
    let outputUnits = ["C", "F", "K"]
    
    var convertedDegreeC2F: Int {
        guard let inputDegree = Int(inputTemp) else { return 0 }
        let convertC2F = Int(inputDegree/5*9+32)
        let convertF2C = Int((inputDegree-32)*5/9)
        let convertC2K = Double(inputDegree) + 273.15
        let convertK2C = Double(inputDegree) - 273.15
        
        if inputUnit == 0 && outputUnit == 1 {
            return convertC2F
        } else if inputUnit == 1 && outputUnit == 0 {
            return convertF2C
        } else if inputUnit == 0 && outputUnit == 2 {
            return Int(convertC2K)
        } else if inputUnit == 2 && outputUnit == 0 {
            return Int(convertK2C)
        }
        
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Temperature", text: $inputTemp)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section(header: Text("Select input unit:" )) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0..<inputUnits.count) {
                            Text("\(self.inputUnits[$0])°")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Select output unit:" )) {
                    Picker("Output Unit", selection: $outputUnit){
                        ForEach(0..<outputUnits.count) {
                            Text("\(self.outputUnits[$0])°")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Temperature after conversion is:")) {
                    Text("\(convertedDegreeC2F)°")
                }
            }
            .navigationBarTitle("UConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
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

