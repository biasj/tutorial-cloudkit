//
//  ContentView.swift
//  CloudKitApp
//
//  Created by Beatriz Sato on 28/08/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gerenciadorLista: GerenciadorLista
    
    @State private var showListForm = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(gerenciadorLista.listas, id: \.self) { lista in
                        Text(lista.nome)
                    }
                    .onDelete(perform: delete)
                }
                
                Button("Adicionar lista") {
                    showListForm.toggle()
                }
                
            }
            .sheet(isPresented: $showListForm, content: {
                ListFormView(lista: Lista(nome: "", descricao: ""))
            })
            .navigationBarTitle("Listas ☁️", displayMode: .inline)
            .toolbar {
                EditButton()
            }
            .onAppear(perform: {
                gerenciadorLista.pegarListas()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func delete(at offsets: IndexSet) {
        gerenciadorLista.deletarLista(lista: gerenciadorLista.listas[offsets.first!])
        gerenciadorLista.listas.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
