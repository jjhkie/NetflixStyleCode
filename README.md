# NetflixStyleCode
Netflix UI Style

## [ 사용한 기술 ]

  - SnapKit [ https://github.com/SnapKit/SnapKit ] 
  
  - #CollectionView 
  
     - DataSource 
        - 필수 요소
        - content 관리 및 content 표시에 필요한 view 생성

     - Delegate
        - 선택 요소
        - 특정 상황에서 view 동작 custom 

     - ReusableView 
        - 재사용 view

     - ViewLayout
     - LayoutAttributtes
     - UpdateItem
        - 각 항목 배치 등 시각적 스타일 담당
        - view 를 직접 소유하지 않는 대신 Attributes 생성
        - 데이터 항목 수정 시 UpdateItem 인스턴스 수신



     - FlowLayout
     - DelegateFlowLayout
        - Grid, line-based layout 구현
        - 레이아웃 정보를 동적으로 Custom

  
## [ Point ] 

  - initializer Page 설정 정보르 변경하는 방법
    
    1. 설정 정보는 info.plist 파일에 저장되어 있다.
    
    2. 해당 정보를 삭제한 후 SceneDelegate 에서 설정해줄 수 있다.
      [ 참고 : SceneDelegate 에 설정하는 코드가 작성되어 있다.  ]
      
## [ ADD ]

  - UICollectionViewCompositionalLayout
  
    - iOS 13 지원 
    - 복잡한 UI를 단순한 것으로 구성한다.
    - 이것만으로 모든 레이아웃을 작성 가능하게 한다.
    - 프레임워크에서 자체 성능 최적화 수행 
	
  
  - NSCollectionLayoutSize
    - Absolute
    - Estimate
    - Fractional
    
  - NSCollectionLayoutItem
  
  - NSCollectionLayoutGroup
  
  - NSCollectionLayoutSection
  
  - NSCollectionViewCompositionalLayout
