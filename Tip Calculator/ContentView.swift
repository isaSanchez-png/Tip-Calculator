import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TipManager()
    @FocusState private var totalIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section("Datos de la cuenta") {
                    TextField("Total de la cuenta", value: $viewModel.tipData.total, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($totalIsFocused)
                    
                    Picker("Porcentaje de propina", selection: $viewModel.tipData.tipPercentage) {
                        Text("10%").tag(10)
                        Text("15%").tag(15)
                        Text("18%").tag(18)
                        Text("20%").tag(20)
                        Text("Otro").tag(-1)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: viewModel.tipData.tipPercentage) { oldValue, newValue in
                        if newValue == -1 {
                            viewModel.activeCustomMode()
                        } else {
                            viewModel.selectCustomTip(newValue)
                        }
                    }
                    
                    if viewModel.tipData.tipPercentage == -1 {
                        HStack {
                            Text("Porcentaje:")
                            TextField("0", value: $viewModel.tipData.percentageCustom, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 80)
                                .onChange(of: viewModel.tipData.percentageCustom) { oldValue, newValue in
                                    viewModel.updateCustomTipPercentage(newValue)
                                }
                            Text("%")
                            Spacer()
                        }
                        .padding(.top, 8)
                    }
                    
                    Stepper("Personas: \(viewModel.tipData.numberOfPeople)", value: $viewModel.tipData.numberOfPeople, in: 1...20)
                }
                
                Section("Resultados") {
                    HStack {
                        Text("Propina:")
                        Spacer()
                        Text(viewModel.tipData.tipAmount, format: .currency(code: "USD"))
                            .foregroundColor(.green)
                    }
                    
                    HStack {
                        Text("Total con propina:")
                        Spacer()
                        Text(viewModel.tipData.totalIncludingTip, format: .currency(code: "USD"))
                            .bold()
                    }
                    
                    HStack {
                        Text("Por persona:")
                        Spacer()
                        Text(viewModel.tipData.tipPerPerson, format: .currency(code: "USD"))
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Calculadora de Propina")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Listo") {
                        totalIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
