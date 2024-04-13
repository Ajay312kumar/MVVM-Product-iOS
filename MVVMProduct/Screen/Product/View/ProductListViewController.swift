//
//  ProductListViewController.swift
//  MVVMProduct
//
//  Created by ajay kumar on 12/04/24.
//

import UIKit

class ProductListViewController: UIViewController {
    
   private var viewModel = ProductViewModel()

    @IBOutlet weak var productTableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        productTableView.delegate = self
        productTableView.dataSource = self
        configuration()
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    


}
extension ProductListViewController{
    
    func configuration(){
        initModelEvent()
        observeEvent()
    }
    
    func initModelEvent(){
        viewModel.fetchProducts()
    }
    
    func observeEvent(){
        
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("Product loading....")
                
            case .stopLoading:
                print("Stop loading...")
                
            case .dataLoaded:
                print("data loaded...")
                print(self.viewModel.products)
                DispatchQueue.main.async{
                    self.productTableView.reloadData()
                }
                
            case .error(let error):
                print(error)
            }
            
        }
    }
}
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else{
            return UITableViewCell()
        }
        
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}
