import UIKit
import RxSwift

class TipViewController: ViewController {
    private let collectionView = CollectionView(minimumLineSpacing: 0, minimumInteritemSpacing: 0)
    private let id: Int
    private let orderSum: Double
    
    private var restaurant: Restaurant? = Restaurant.sampleData
    private var titles: [String] = []
    private var selectedIndex: Int = 1
    
    private let activityIndicator: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        return view
    }()
    
    init(id: Int, orderSum: Double) {
        self.id = id
        self.orderSum = orderSum
        super.init(isNavBarHidden: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        
        setViews()
        setTitles(8)
    }
    
    private func setTitles(_ average: Double) {
        guard self.restaurant != nil else { return }
        
        var procents: [Double] = []
        if average > 5.0 {
            procents = [5, average, 10]
        } else if average == 10.0 {
            procents = [5, 10, 15]
        } else {
            procents = [10, average, 15]
        }
     
        titles = procents.map { (value) in
            return "\(value) % - \(orderSum * value / 100) ₽"
        }
        collectionView.reloadData()
    }
    
    private func setViews() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RestaurantTipCell.self)
        collectionView.register(cellType: MultipleChoiceCell.self)
        collectionView.register(cellType: TextFieldCell.self)
        collectionView.register(cellType: SendTipButtonCell.self)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    private func sendTips() {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as? TextFieldCell else {
            return
        }
        
        guard let amount = cell.tipAmount else { return }
        // cell.comment
        // amount
    }
}

extension TipViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        switch indexPath.item {
        case 0:
            return CGSize(width: width - 20 * 2, height: 140)
        case 1:
            return CGSize(width: width - 20 * 2, height: 35 * 3 + 10 * 2)
        case 2:
            return CGSize(width: width - 20 * 2, height: 50)
        case 3:
            return CGSize(width: width, height: 80)
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item == 2 else { return }
        
        selectedIndex = titles.count
        collectionView.reloadData()
    }
}

extension TipViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard restaurant != nil else { return 0 }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        switch index {
        case 0:
            guard let restaurant = self.restaurant else { fatalError() }
            let cell: RestaurantTipCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(restaurant, sum: orderSum)
            return cell
        case 1:
            let cell: MultipleChoiceCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.configure(titles, selectedIndex: selectedIndex)
            return cell
        case 2:
            let cell: TextFieldCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(selectedIndex == titles.count)
            return cell
        case 3:
            let cell: SendTipButtonCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.buttonDidTouch.bind { [weak self] in
                self?.sendTips()
            }.disposed(by: cell.bag)
            return cell
        default:
            fatalError()
        }
    }
}

extension TipViewController: DidSelectCellDelegate {
    func didSelect(_ tag: Int) {
        selectedIndex = tag - 1
        collectionView.reloadData()
    }
}
