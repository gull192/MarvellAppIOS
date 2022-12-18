//
//  ViewController.swift
//  MarvelGruz
//
//  Created by user225687 on 12/18/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  public  let heroes = [
        HeroInfo(title: "Spider man", image: "spider_man"),
        HeroInfo(title: "Captane America", image: "captain_america"),
        HeroInfo(title: "Loki", image: "loki")
    ]
    // MARK: - Constants
    
    let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    let cellHeight = (1 / 2 ) * UIScreen.main.bounds.height
    let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    let colors: [UIColor] = [.red, .green, .blue, .purple, .orange, .black, .cyan]
    let cellId = "cell id"
    let backgoundColor = UIColor.gray
    
    // MARK: - UI Components
    
    lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var tetxtTitl : UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.textColor = .white
        title.font = .systemFont(ofSize: 32)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Choose your hero"
        return title
    }()
    
    lazy var mainImage : UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "marvel")
        image.backgroundColor = backgoundColor
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        self.view.addSubview(mainImage)
        self.view.addSubview(tetxtTitl)
        registerCollectionViewCells()
        self.view.addSubview(collectionView)
        applyConstraints()
    }
    
    // MARK: - Setup
    
    private func design() {
        view.backgroundColor = backgoundColor
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func applyConstraints() {
        mainImage.snp.makeConstraints{ make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize(width: self.view.bounds.width/3, height: 44))
            make.top.equalTo(self.view.snp_topMargin).offset(40)
            
        }
        
        tetxtTitl.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(mainImage.snp_bottomMargin).offset(16)
        }
        collectionView.snp.makeConstraints{ make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view.snp_bottomMargin).offset(-30)
            make.left.equalTo(self.view.snp_leftMargin)
            make.right.equalTo(self.view.snp_rightMargin)
            make.top.equalTo(tetxtTitl.snp_bottomMargin).offset(10)
        }
    }
    
}

// MARK: - CollectionView Data Source

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        lazy var  backgroundImage: UIImageView = {
           let image =  UIImageView()
            image.image = UIImage(named: heroes[indexPath.item].image)
            image.contentMode = .scaleToFill
            return image
        }()
        
        lazy var  nameHero: UILabel = {
            let title = UILabel()
            title.text = heroes[indexPath.item].title
            title.textColor = .white
            title.textAlignment = .left
            return title
        }()
        
        cell.backgroundView = backgroundImage
        cell.addSubview(nameHero)
        nameHero.snp.makeConstraints { make in
            make.bottom.equalTo(cell.snp_bottomMargin).offset(-10)
            make.left.equalTo(cell.snp_leftMargin).offset(16)
        }
        let color = colors[indexPath.item]
        cell.backgroundColor = color
        return cell
    }
    
}




