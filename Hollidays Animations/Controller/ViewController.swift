//
//  ViewController.swift
//  Hollidays Animations
//
//  Created by Bruno Silva on 05/12/2018.
//  Copyright © 2018 Bruno Silva. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let zoomDelegate = ZoomTransitioningDelegate()
    var selectedIndexPath: IndexPath!
    var array: [Holiday] = [
                            Holiday(imageName: "1", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "2", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "3", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "4", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "5", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "6", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "7", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "1", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "2", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "3", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "4", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "5", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "6", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro."),
                            Holiday(imageName: "7", title: "Title 1", description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(CollectionCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 176)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.reusableCell(for: indexPath, with: self.array[indexPath.row]) as CollectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.model = array[indexPath.row]
        self.navigationController?.delegate = zoomDelegate
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        self.selectedIndexPath = indexPath
    }
    
}

extension ViewController: ZoomingViewController {
    func zoomingTitleLabel(for transition: ZoomTransitioningDelegate) -> UILabel? {
        if let indexPath = self.selectedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
            return cell.titleLabel
        }
        
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        if let indexPath = self.selectedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
            return cell.imageView
        }
        
        return nil
    }
    
    func zoomingDetailView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    func zoomingShadowView(for transition: ZoomTransitioningDelegate) -> UIView? {
        if let indexPath = self.selectedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
            return cell.shadowView
        }
        
        return nil
    }

}
