//
// ---------------------------- //
// Original Project: SwiftDataUIkit2
// Created on 2024-12-08 by Tim Mitra
// Mastodon: @timmitra@mastodon.social
// Twitter/X: timmitra@twitter.com
// Web site: https://www.it-guy.com
// ---------------------------- //
// Copyright © 2024 iT Guy Technologies. All rights reserved.


import UIKit
import SwiftData

class ViewController: UIViewController {

    var container: ModelContainer?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = try? ModelContainer(for: User.self)
        loadUsers()
        
        title = "Add Users"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Samples", style: .plain, target: self, action: #selector(addSamples))
    }
    
    override func loadView() {
        super.loadView()
        
        createCollectionView()
        createDataSource()
    }
    
    func createCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "User")
    }
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView) { collectionView, indexPath, user in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "User", for: indexPath)
            
            var content = UIListContentConfiguration.cell()
            content.text = "\(user.name) was born in \(user.birthYear)"
            cell.contentConfiguration = content
            
            return cell
        }
        
        // Add this code to apply an initial empty snapshot
            var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
            snapshot.appendSections([.users])
            dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func loadUsers() {
        let descriptor = FetchDescriptor<User>()
        let users = (try? container?.mainContext.fetch(descriptor)) ?? []
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.users])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func addSamples() {
        let taylor = User(name: "Taylor Swift", birthYear: 1989)
        let beyonce = User(name: " Beyoncé", birthYear: 1981)
        let johnnyCash = User(name: "Johnny Cash", birthYear: 1935)
        
        container?.mainContext.insert(taylor)
        container?.mainContext.insert(beyonce)
        container?.mainContext.insert(johnnyCash)
        
        loadUsers()
    }


}

