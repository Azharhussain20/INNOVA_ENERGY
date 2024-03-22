import UIKit
import SwiftUI
import DropDown

struct Mode {
    let image: String
    let selectedImage: String
    let steps: String
    var isSelected: Bool
}
class DeviceDetailsViewController: BaseViewController, dateRangeSelectionViewControllerDelegate, FanModeSelectorDelegate, TemperatureSliderViewModelDelegate{
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var CollectionMode: UICollectionView!
    @IBOutlet var circularRingSlider: UIView!
    @IBOutlet weak var fanModeView: FanModeSelector!
    //------------------------------------------
    //MARK: - Class Variables -
    var fromDate = Date()
    var toDate = Date()
    var isInfoVisible : Bool = false
    var modeData: [Mode] = [
        Mode(image: "in_autoMode", selectedImage:"in_autoModeSelected", steps: "Auto".localize(), isSelected: true),
        Mode(image: "in_heatMode", selectedImage:"in_heatModeSelected", steps: "Heat".localize(), isSelected: false),
        Mode(image: "in_coolMode", selectedImage:"in_coolModeSelected", steps: "Cool".localize(), isSelected: false),
        Mode(image: "in_dryMode", selectedImage:"in_dryModeSelected", steps: "Dry".localize(), isSelected: false),
        Mode(image: "in_fanMode", selectedImage:"in_fanModeSelected", steps: "Fan".localize(), isSelected: false),
    ]
    
    let arrValues = Array(stride(from: 0, through: 30, by: 0.1)).map { CGFloat($0.rounded(toPlaces: 1)) }
    let dropDown = DropDown()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetup()
        xibRegisterations()
        loadTempratureManager()
    }
    
    func loadTempratureManager(){
        let viewModel = TemperatureSliderViewModel()
        viewModel.delegate = self
        let childView = UIHostingController(rootView: TemperatureSlider(sliderData: viewModel))
        addChild(childView)
        childView.view.frame = circularRingSlider.bounds
        circularRingSlider.addSubview(childView.view)
        childView.didMove(toParent: self)
        fanModeView.delegate = self
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    //------------------------------------------
    //MARK: - Custom Methods -
    func collectionAnimation(_ view: UICollectionView) {
        view.visibleCells.forEach { cell in
            cell.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                cell.transform = .identity
            }, completion: nil)
        }
    }
    
    func getbarButtons(image: String, setTag: Int) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: image), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(btnBarItemGearTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.tag = setTag
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    
    func navigationSetup() {
        configurationTitleAndBack(title: "Device 1", imageName: "in_leftPrimary")
        backTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationItem.rightBarButtonItems = [getbarButtons(image: "in_gear", setTag: 1)]
    }
    
    
    
    func xibRegisterations() {
        CollectionMode.register(UINib(nibName: "ModeTypesCell", bundle: nil), forCellWithReuseIdentifier: "ModeTypesCell")
    }
    
    
    //------------------------------------------
    //MARK: - Custom Delegates
    func temperatureDidUpdate(temperature: Double) {
        print(temperature)
    }
    
    func powerBtnClicked() {
        print("Power button Clicked")
    }
    
    func selectedRanges(from: Date, toDate: Date) {
        self.fromDate = from
        self.toDate = toDate
    }
    
    func fanModeDidSelect(mode: Device.FanMode) {
        print(mode)
    }
    
    //------------------------------------------
    //MARK: - Action Methods -

    @objc func btnBarItemGearTapped(sender: UIButton) {
        let initiliazeVC : DeviceSettingsViewController = Utilities.viewController(name: "DeviceSettingsViewController", onStoryboard: "DeviceDetails") as! DeviceSettingsViewController
        initiliazeVC.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(initiliazeVC, animated: true)
    }
    
}

//------------------------------------------
//MARK: - Collection Delegates -
extension DeviceDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModeTypesCell", for: indexPath) as! ModeTypesCell
        cell.lblMode.text = modeData[indexPath.row].steps
        if modeData[indexPath.row].isSelected {
            cell.imgMode.image = UIImage(named: modeData[indexPath.row].selectedImage)
            cell.lblMode.textColor = appConfig.appColors.themeColor
        } else {
            cell.imgMode.image = UIImage(named: modeData[indexPath.row].image)
            cell.lblMode.textColor = appConfig.appColors.btnInActiveTextColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 5
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: UIScreen.main.bounds.size.height * 0.105634)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<modeData.count {
            modeData[i].isSelected = false
        }
        modeData[indexPath.row].isSelected = true
        CollectionMode.reloadData()
        
        let initiliazeVC : ModeManagerViewController = Utilities.viewController(name: "ModeManagerViewController", onStoryboard: "DeviceDetails") as! ModeManagerViewController
        initiliazeVC.delegate = self
        initiliazeVC.fromDate = fromDate
        initiliazeVC.toDate = toDate
        let sheet = initiliazeVC.sheetPresentationController
        sheet?.preferredCornerRadius = 16.0
        sheet?.prefersGrabberVisible = true
        if #available(iOS 16.0, *) {
            let fraction = UISheetPresentationController.Detent.custom { context in
                314.0
            }
            sheet?.detents = [fraction]
        } else {
            sheet?.detents = [.medium()]
        }
        present(initiliazeVC, animated: true, completion: nil)
    }
}

//------------------------------------------
//MARK: - Timezone conversion -
extension Date {
    func convertToTimeZone(timeZone: TimeZone) -> Date {
        let seconds = TimeInterval(timeZone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
