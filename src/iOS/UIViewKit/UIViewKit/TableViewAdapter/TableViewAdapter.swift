//
//  TableViewAdapter.swift
//  UIViewKit
//
//  Created by Artem Kufaev on 25.04.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

<<<<<<< HEAD
public class TableViewAdapter<Model, Cell>: NSObject,
    UITableViewDelegate,
    UITableViewDataSource
    where Cell: ConfigurableCell, Model == Cell.ViewModel {
=======
public class TableViewAdapter<Cell: UITableViewCell & ConfigurableCell>: NSObject,
    UITableViewDelegate,
    UITableViewDataSource {
    
    public typealias Model = Cell.ViewModel
>>>>>>> ios/feature/uiviewkit
    
    private(set) weak var tableView: UITableView!
    private(set) var viewModels: [Model] = [] {
        didSet { tableView.reloadData() }
    }
    
    public init(table: UITableView) {
        self.tableView = table
        super.init()
        table.dataSource = self
        table.delegate = self
        table.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    public func set(items: [Model]) {
        self.viewModels = items
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = self.tableView.dequeueReusableCell(for: indexPath)
        let viewModel = self.viewModels[indexPath.row]
        cell.configure(viewModel, at: indexPath)
        return cell
    }
    
}
