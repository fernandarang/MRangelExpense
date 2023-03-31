//
//  AddCategoriaViewController.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 30/03/23.
//

import UIKit
import iOSDropDown

class AddCategoriaViewController: UIViewController {
    
    @IBOutlet weak var SelectSegment: UISegmentedControl!
    @IBOutlet weak var Categoria: UITextField!
    @IBOutlet weak var SubCategoria: UITextField!
    @IBOutlet weak var AddAccion: UIButton!
    @IBOutlet weak var Selectategoria: DropDown!
    
    var categoriasViewModel = CategoriasViewModel()
    var idCategoria = 0
    var Categorias = categorias()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Selectategoria.isSearchEnable = false
        Selectategoria.selectedRowColor = UIColor(named: "AccentColor")!
        Selectategoria.arrowSize = 10
        Selectategoria.arrowColor = .systemIndigo
        SubCategoria.isHidden = true
        Selectategoria.isHidden = true
        SelectSegment.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SelectAdd(_ sender: Any) {
        
        if SelectSegment.selectedSegmentIndex == 0 {
            SubCategoria.isHidden = true
            Selectategoria.isHidden = true
            Categoria.isHidden = false
            AddAccion.setTitle("Add Categoria", for: .normal)
        }else{
            viewWillAppear(true)
            SubCategoria.isHidden = false
            Selectategoria.isHidden = false
            Categoria.isHidden = true
            AddAccion.setTitle("Add SubCategoria", for: .normal)
        }
        
    }
    
    @IBAction func AddAccion(_ sender: UIButton) {
        if SelectSegment.selectedSegmentIndex == 0{
            AddCategoria()
        }else{
            AddSubCategoria()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           loadCategoria()
       }
       
       func loadCategoria(){
           Selectategoria.optionIds = []
           Selectategoria.optionArray = []
           let result = categoriasViewModel.getall()
           if result.Correct == true{
               for categories in result.Objects! as! [categorias]{
                   Selectategoria.backgroundColor = .white
                   Selectategoria.optionIds?.append(categories.IdCategorias)
                   Selectategoria.optionArray.append(categories.NameCategorias)
               }
               Selectategoria.didSelect{ [self](selectedText , index ,id) in
                   Selectategoria.selectedRowColor = UIColor(named: "AccentColor")!
                   Selectategoria.arrowSize = 10
                   Selectategoria.arrowColor = UIColor(named: "AccentColor")!
                   
                   self.Selectategoria.text = String(selectedText)
                   self.idCategoria = id
               }
           }
       }
    
    func AddCategoria(){
        guard let nombre = Categoria.text, Categoria.text != nil, Categoria.text != "" else{
            Categoria.backgroundColor = .red
            return
        }
        let cate = categorias(IdCategorias: 0, NameCategorias: nombre)
        let result = categoriasViewModel.addCategoria(categoria: cate)
        if result.Correct == true {
            
            let alert = UIAlertController(title: "Confirmación", message: "Subcategoria agregada correctamente", preferredStyle: .alert)
            //let ok = UIAlertAction(title: "OK", style: .default)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                            { action in
                self.Categoria.text = ""
            })
            //alert.addAction(ok)
            alert.addAction(Aceptar)
            self.present(alert, animated: true)
            
        }else{
            let alertError = UIAlertController(title: "Error", message: "La SubCategoria no se pudo agregar "+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: true)
        }
    }
    
    func AddSubCategoria(){
        viewWillAppear(true)
        guard let nombreSubcategoria = SubCategoria.text, SubCategoria.text != nil, SubCategoria.text != "" else {
            SubCategoria.backgroundColor = .red
            return
        }
        guard let selectCategoria = Selectategoria.text, Selectategoria.text != nil, Selectategoria.text != "" else {
            Selectategoria.backgroundColor = .red
            return
        }
        let idCategoria = Int(idCategoria)
        let subCate = SubCategorias(IdSubcategorias: 0, nameSubCategoria: nombreSubcategoria, idCategoria: idCategoria)
        let result = categoriasViewModel.addSubCategoria(subcategoria: subCate)
        
        if result.Correct == true{
            
            let alert = UIAlertController(title: "Confirmación", message: "SubCategoria agregada correctamente", preferredStyle: .alert)
            let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                            { action in
                self.SubCategoria.text = ""
                self.Selectategoria.text = ""
            })
            alert.addAction(Aceptar)
            self.present(alert, animated: true)
        }
        else{
            
            let alertError = UIAlertController(title: "Error", message: "La SubCategoria no se pudo agregar "+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: true)
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
