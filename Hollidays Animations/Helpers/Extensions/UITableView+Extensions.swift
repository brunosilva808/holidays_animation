//
//  UITableView+Extensions.swift
//  SmartDrive
//
//  Created by Artem Umanets on 13/08/2018.
//  Copyright © 2018 Carbon by Bold. All rights reserved.
//

import UIKit

public protocol ReusableView: class {
    
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

public extension ReusableView {
    
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.reuseIdentifier, bundle: nil) }
}

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }

public protocol ModelPresenterCell {
    
    associatedtype Model
    var model: Model? { get set}
}

public extension UITableView {
    
    public func registerNib<T: UITableViewCell>(for cellClass: T.Type, in bundle: Bundle? = nil) {
        
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    public func register<T: UITableViewCell>(_ cellClass: T.Type) {
        
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
        register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(for section: Int) -> T {
        
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    public func cell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        
        return self.cellForRow(at: indexPath) as! T
    }
}

extension UITableView {

    func setTopBounce(color: UIColor = .white, size: CGSize = UIScreen.main.bounds.size) {
        let view = UIView(frame: CGRect(x: self.bounds.origin.x, y: -size.height, width: size.width, height: size.height))
        view.backgroundColor = color
        self.addSubview(view)
    }
    
    public func reusableCell<T: UITableViewCell>(for indexPath: IndexPath, with model: T.Model) -> T where T: ModelPresenterCell {
        
        var cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
        cell.model = model
        return cell
    }
    
    func cell<T: UITableViewCell>(for type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func cell<T: UITableViewCell>(forIdentifier identifier: String) -> T {
        return self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
}

public extension UICollectionView {
    
    func setTopBounce(color: UIColor = .white, size: CGSize = UIScreen.main.bounds.size) {
        let view = UIView(frame: CGRect(x: self.bounds.origin.x, y: -size.height, width: size.width, height: size.height))
        view.backgroundColor = color
        self.addSubview(view)
    }
    
    public func reusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, with model: T.Model) -> T where T: ModelPresenterCell {
        
        var cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        cell.model = model
        return cell
    }
}
