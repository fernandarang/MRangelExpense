//
//  CategoriasViewController.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 29/03/23.
//

import UIKit

class CategoriasViewController: UIViewController, UISearchBarDelegate {
    
    var idSubcategoria = 0
    var nameSubcategory = ""
    var busquedanormal = true
    var CategoriaArray = [categorias]()
    var subcategoriasarray = [SubCategorias]()
    let categoriasviewmodel = CategoriasViewModel()
    var seccion = 0
    let alert = UIAlertController(title: nil, message: "Se agrego correctamente", preferredStyle: .alert)
    let alertfalse = UIAlertController(title: nil, message: "Ocurrio un Error", preferredStyle: .alert)
    let Ok = UIAlertAction(title: "Ok", style: .default)
    var numer = 1
    
    @IBOutlet weak var CategoriasTableView: UITableView!
    @IBOutlet weak var SearchField: UITextField!
    @IBOutlet weak var searchbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CategoriasTableView.dataSource = self
        CategoriasTableView.delegate = self
        
        alert.addAction(Ok)
        alertfalse.addAction(Ok)
        CategoriasTableView.delegate = self
        CategoriasTableView.dataSource = self
        view.addSubview(CategoriasTableView)
                
        CategoriasTableView.register(UINib(nibName: "SubCategoriasTableViewCell", bundle: .main), forCellReuseIdentifier: "SubCategoriaCell")
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText != ""{
//            let result = categoriasviewmodel.getbyNombre2(nombrecategoria: searchText)
//            if result.Correct{
//                subcategoriasarray = result.Objects as! [SubCategorias]
//                CategoriasTableView.reloadData()
//            }
//        }else{
//            loadData()
//        }
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            loadData()
    }
        
        func loadData(){
            let  result = categoriasviewmodel.getall()
            if result.Correct == true{
                
                CategoriaArray = result.Objects as! [categorias]
                //print(CategoriaArray)
                CategoriasTableView.reloadData()
            }
            else
            {
                self.present(alertfalse, animated: true)
                print(result.ErrorMessage)
            }
            
            
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CategoriasViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if busquedanormal == true{

                    return CategoriaArray.count
                }
                else{
                    return 1
                }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if busquedanormal == true{
                var name = CategoriaArray[section].NameCategorias
                seccion = section

                return name}
            else{
                return nil
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if busquedanormal == true{
                    return CategoriaArray[section].subcategorias!.count}
                else{
                    return subcategoriasarray.count
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoriaCell", for: indexPath as IndexPath) as! SubCategoriasTableViewCell
                if busquedanormal == true{
                    cell.nombreCategoriaLbl.text = CategoriaArray[indexPath.section].subcategorias![indexPath.row].nameSubCategoria
                }
                else{
                    cell.nombreCategoriaLbl.text = subcategoriasarray[indexPath.row].nameSubCategoria

                }

                return cell
    }
    
    func searchbynombre(){
            busquedanormal = false
            subcategoriasarray = [SubCategorias]()
            let result =  categoriasviewmodel.getbyNombre(nombrecategoria: SearchField.text!)
            if result.Correct == true{
                subcategoriasarray = result.Objects as! [SubCategorias]
                CategoriasTableView.reloadData()
            }
            else{
                self.present(alertfalse, animated: true)
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if busquedanormal == true{
                nameSubcategory = CategoriaArray[indexPath.section].subcategorias![indexPath.row].nameSubCategoria
                idSubcategoria = CategoriaArray[indexPath.section].subcategorias![indexPath.row].IdSubcategorias
            }
            else{
                nameSubcategory = subcategoriasarray[indexPath.row].nameSubCategoria
                idSubcategoria = subcategoriasarray[indexPath.row].IdSubcategorias
            }
            performSegue(withIdentifier: "MovimientoSegue", sender: nil)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "MovimientoSegue"{
                let detail = segue.destination as! MovimientosViewController
                detail.subcategorianame = nameSubcategory
                detail.idSubcategory = idSubcategoria
            }
        }
        

        @IBAction func SearchAction(_ sender: Any) {
            searchbynombre()
        }
}
