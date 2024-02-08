//
//  NewAndHotViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/8/24.
//

import UIKit

enum NewAndHotTag: CaseIterable {
    case upcoming
    case popular
    case top10Series
    case top10Movie
    
    var title: String {
        switch self {
        case .upcoming:
            return "🍿 공개 예정"
        case .popular:
            return "🔥 모두의 인기 콘텐츠"
        case .top10Series:
            return "📺 Top 10 시리즈"
        case .top10Movie:
            return "🎬 Top 10 영화"
        }
    }
}

class NewAndHotViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        configureHierarchy()
        configureView()
        setupConstraints()
    }
    
    @objc func searchButtonTapped() {
        
    }
}

extension NewAndHotViewController {
    
    func configureNavigationItem() {
        navigationItem.title = "NEW & HOT"
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func configureView() {
        configureCollectionView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewAndHotTableViewCell.self, forCellReuseIdentifier: NewAndHotTableViewCell.identifier)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension NewAndHotViewController: CollectionViewProtocol {
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let spacing: CGFloat = 16
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }
    
}

extension NewAndHotViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewAndHotTag.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        
        cell.label.text = NewAndHotTag.allCases[indexPath.item].title
        
        return cell
    }
    
}

extension NewAndHotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewAndHotTableViewCell.identifier, for: indexPath) as! NewAndHotTableViewCell
        return cell
    }
    
    
}
