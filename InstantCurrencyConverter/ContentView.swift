//
//  ContentView.swift
//  InstantCurrencyConverter
//
//  Created by KADIR ISMAILI on 17.3.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScannerSheet = false
    @State private var texts: [ScanData] = []
    
    @State var input = "100"
    @State var base = "USD"
    
    var body: some View {
        NavigationView {
            VStack {
                if texts.count > 0 {
                    List {
                        ForEach(texts) {text in
                            NavigationLink(destination: ScrollView {Text(text.content)}, label: {
                                Text(text.content).lineLimit(1)
                            })
                        }
                    }
                }
                else {
                    Text("No scan yet")
                        .font(.title)
                }
            }
            .navigationTitle("Scan OCR")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showScannerSheet = true
            }, label: {
                Image(systemName: "doc.text.viewfinder")
                    .font(.title)
            })
                                        .sheet(isPresented: $showScannerSheet, content: {
                                            makeScannerView()
                                        })
            )
            .onAppear {
                apiRequest(url: "https:api.exchangerate.host/latest?base=\(base)$amount=\(input)") { currency in
                    print(currency)
                }
            }
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in:
                    .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
