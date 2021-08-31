//
//  GerenciadorLista.swift
//  CloudKitApp
//
//  Created by Beatriz Sato on 30/08/21.
//

import Foundation

class GerenciadorLista: ObservableObject {
    @Published var listas: [Lista]
    
    var cloudKitGerenciador = CKManager.shared
    
    init() {
        listas = [Lista]()
    }
    
    func pegarListas() {
        cloudKitGerenciador.buscarLista { [self] listasNuvem in
            for lista in listasNuvem {
                let nome = lista.value(forKey: "nome")
                let descricao = lista.value(forKey: "descricao")
                
                let novaLista = Lista(id: lista.recordID, nome: nome as! String, descricao: descricao as? String ?? "")
                listas.append(novaLista)
            }
        }
    }
    
    func salvarLista(lista: Lista) {
        cloudKitGerenciador.salvarLista(lista: lista) { [self] listaNuvem in
            let novaLista = Lista(id: listaNuvem.recordID, nome: lista.nome, descricao: lista.descricao)
            listas.append(novaLista)
        }
    }
    
    func deletarLista(lista: Lista) {
        cloudKitGerenciador.deletarLista(id: lista.id!)
    }
    
}
