//
//  ViewController.swift
//  NoticiasApp
//
//  Created by Mac13 on 30/03/22.
//

import UIKit
import SafariServices
// MARK: - Estructuras
struct Noticias: Codable {
    var articles: [Noticia]
}

struct Noticia: Codable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var url: String?
    var source: Source?
}


struct Source: Codable {
    var name: String?
}

var articulosDeNoticias: [Noticia] = []
var urlMandar: String?

class ViewController: UIViewController{
    //para guardar los articulos de noticias y llenar tabla
    var noticias = [Noticia]()
    

    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaNoticias.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        func analizarJSON(json: Data){
            let decodificador = JSONDecoder()
            if let datosDecodificados = try? decodificador.decode(Noticias.self, from: json){
                print("Articulos de noticias son: \(datosDecodificados.articles.count)")
                print("Los articulos son: \(datosDecodificados.articles)")
            }//if let
        }//func analizarJSON
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                analizarJSON(json: data)
            }//if let data
        }//if let url
        
    }//viewdidload


}//class vc

// MARK: -Metodos del IUTableView
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosDeNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaTableViewCell
        celda.tituloNoticiaLbl.text = articulosDeNoticias[indexPath.row].title
        celda.descripcionNoticiaLbl.text = articulosDeNoticias[indexPath.row].description
        celda.fuenteNoticiaView.text = articulosDeNoticias[indexPath.row].source?.name
        
        // MARK: -Crear imagen de sitio web
        let urlImagen = articulosDeNoticias[indexPath.row].urlToImage ?? ""
        celda.imagenNoticiaIV.cargadesdeSitioweb(direccionURL: urlImagen)
        return celda
    }//fin func tableview
}//fin func tableviewcell

extension UIImageView{
        func cargadesdeSitioweb(direccionURL: String){
            guard let url = URL(string: direccionURL) else {
            return }
            DispatchQueue.main.async {
                if let imagenData = try? Data(contentsOf: url){
                    if let imagenCargada = UIImage(data: imagenData){
                        self.image = imagenCargada
                    }//fin if let imagen cargada
                }//fin if let imagen data
            }//fin dispatchqueue
        }//fin cargadesdeSitioweb
}//fin extension uiimageview
