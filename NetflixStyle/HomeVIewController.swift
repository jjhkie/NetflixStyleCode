
import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController{
    
    var contents: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Navigation 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "neflix_ico") , style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        
        //정보 가져오기
        contents = getContents()
        
        //CollectionView Item(Cell) Setting
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
    
        ///Header Setting
        /// 첫 번째 방법
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
        ///두 번쨰 방법
        ///collectionView.register(ContentCollectionViewHeader.self, forCellWithReuseIdentifier: "ContentCollectionViewHeader")
    }
    
    /// 정보 가져오기
    func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return []}
        return list
    }
    
    
    /// 각각의 섹션 타입에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout{[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil}
            
            switch self.contents[sectionNumber].sectionType{
            case .basic:
                return self.createBasicTypeSection()
                
            default:
                return nil
            }
        }
    }
    
    /// Total Section Setting
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
        
    }
}

/// UICollectionView DataSource, Delegate
extension HomeViewController{
    
    //section 마다 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    //CollectionView Cell Setting
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType{
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath)as? ContentCollectionViewCell else { return UICollectionViewCell()}
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //Header View Setting
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header")}
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    //Section 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    //Cell 선택했을 때 실행되는 코드
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("\(sectionName) 섹션의 \(indexPath.row+1)번쨰 콘텐츠")
    }
}

//SwiftUI를 활용한 미리보기
struct HomeViewController_Previews: PreviewProvider{
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            
            return UINavigationController(rootViewController: homeViewController)
        }
    
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}
