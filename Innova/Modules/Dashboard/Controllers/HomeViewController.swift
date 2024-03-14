import UIKit
import DropDown

struct Services {
    var sectionName: String
    var sectionData: [ServiceObject]
}

struct ServiceObject {
    var temperature: Double
    var deviceName: String
    var roomName: String
    var isSwitchOn: Bool
    var isConnected: Bool
    var isPaused: Bool

}

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var colHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionTemp: UICollectionView!
    @IBOutlet weak var btnAddDevice: GreenBordered!
    @IBOutlet weak var btnAddRoom: GreenBackGroundPlus!
    @IBOutlet weak var servicesCollection: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    //------------------------------------------
    //MARK: - Class Variables -
    var isUpArrow = true
    var buttonText = "Casa"
    let dropDown = DropDown()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    let temperatureData: [Services] = [
        Services(sectionName: "Living room".localize(), sectionData: [
            ServiceObject(temperature: 22.0, deviceName: "Device".localize(), roomName: "Living room".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 23, deviceName: "Device".localize(), roomName: "Living room".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 21.0, deviceName: "Device".localize(), roomName: "Living room".localize(), isSwitchOn: true, isConnected: true, isPaused: true),
            ServiceObject(temperature: 24, deviceName: "Device".localize(), roomName: "Living room".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 25.5, deviceName: "Device".localize(), roomName: "Living room".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 20, deviceName: "Device".localize(), roomName: "Living room".localize(), isSwitchOn: false, isConnected: false, isPaused: true)
        ]),
        Services(sectionName: "Lobby".localize(), sectionData: [
            ServiceObject(temperature: 24.0, deviceName: "Device".localize(), roomName: "Lobby".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 25.1, deviceName: "Device".localize(), roomName: "Lobby".localize(), isSwitchOn: true, isConnected: true, isPaused: true),
            ServiceObject(temperature: 23.1, deviceName: "Device".localize(), roomName: "Lobby".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 26.5, deviceName: "Device".localize(), roomName: "Lobby".localize(), isSwitchOn: false, isConnected: true, isPaused: false),
            ServiceObject(temperature: 22.0, deviceName: "Device".localize(), roomName: "Lobby".localize(), isSwitchOn: true, isConnected: true, isPaused: true),
            ServiceObject(temperature: 21.5, deviceName: "Device".localize(), roomName: "Lobby".localize(), isSwitchOn: false, isConnected: false, isPaused: false)
        ]),
        Services(sectionName: "Kitchen".localize(), sectionData: [
            ServiceObject(temperature: 25.6, deviceName: "Device".localize(), roomName: "Kitchen".localize(), isSwitchOn: true, isConnected: false, isPaused: false),
            ServiceObject(temperature: 24.0, deviceName: "Device".localize(), roomName: "Kitchen".localize(), isSwitchOn: true, isConnected: true, isPaused: false),
            ServiceObject(temperature: 26.0, deviceName: "Device".localize(), roomName: "Kitchen".localize(), isSwitchOn: true, isConnected: false, isPaused: true),
            ServiceObject(temperature: 23.6, deviceName: "Device".localize(), roomName: "Kitchen".localize(), isSwitchOn: false, isConnected: false, isPaused: false),
            ServiceObject(temperature: 22.0, deviceName: "Device".localize(), roomName: "Kitchen".localize(), isSwitchOn: false, isConnected: true, isPaused: false),
            ServiceObject(temperature: 27.0, deviceName: "Device".localize(), roomName: "Kitchen".localize(), isSwitchOn: true, isConnected: false, isPaused: true)
        ]),
        Services(sectionName: "Bath".localize(), sectionData: [
            ServiceObject(temperature: 28.7, deviceName: "Device".localize(), roomName: "Bath".localize(), isSwitchOn: true, isConnected: true, isPaused: false),
            ServiceObject(temperature: 27.7, deviceName: "Device".localize(), roomName: "Bath".localize(), isSwitchOn: true, isConnected: false, isPaused: true),
            ServiceObject(temperature: 29.8, deviceName: "Device".localize(), roomName: "Bath".localize(), isSwitchOn: true, isConnected: true, isPaused: false),
            ServiceObject(temperature: 26.8, deviceName: "Device".localize(), roomName: "Bath".localize(), isSwitchOn: true, isConnected: true, isPaused: false),
            ServiceObject(temperature: 30.0, deviceName: "Device".localize(), roomName: "Bath".localize(), isSwitchOn: false, isConnected: false, isPaused: false),
            ServiceObject(temperature: 29.0, deviceName: "Device".localize(), roomName: "Bath".localize(), isSwitchOn: false, isConnected: true, isPaused: true)
        ])
    ]
    
    let data: [(imageName: String, text: String)] = [
        ("in_clouds", "Location not detected".localize()),
        ("in_dropDown2", "Active Devices".localize()),
        ("in_dropDown3", "Add a device".localize()),
        ("in_dropDown4", "Room addition".localize()),
    ]
    
    //------------------------------------------
    //MARK: - Memory Management -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        
    }
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegisterations()
        navigationSetup()
        customActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateContentHeight()
        collectionTemp.visibleCells.forEach { cell in
            cell.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .transitionCrossDissolve, animations: {
                cell.transform = .identity
            }, completion: nil)
        }
    }
    
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func customActions() {
        btnAddDevice.touchUpInside = { [weak self] in
            self?.setEmptyView(isHidden: true)
        }
        
        btnAddRoom.touchUpInside = { [weak self] in
            self?.setEmptyView(isHidden: true)
        }
    }
    
    func getbarButtons(image: String, setTag: Int) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: image), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(btnAlertTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.tag = setTag
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    func navigationSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: returnCustomView())
        navigationItem.rightBarButtonItems = [getbarButtons(image: "in_gear", setTag: 1), getbarButtons(image: "in_plus.png", setTag: 2)]
        navigationController?.hideHairline()
    }
    
    func returnCustomView() -> UIView {
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 117, height: 44))
        view.layer.cornerRadius = 22.0
        view.backgroundColor = appConfig.appColors.themeColor
        
        let dynamicLabelText: UILabel = UILabel(frame: CGRect(x: 24, y: 0, width: 50, height: 44))
        dynamicLabelText.text = "Home".localize()
        dynamicLabelText.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        dynamicLabelText.textColor = UIColor.white
        
        let imageUpDown: UIImageView = UIImageView(frame: CGRect(x: 77, y: 8, width: 28, height: 28))
        imageUpDown.image = UIImage(named: "in_downWhite")
        imageUpDown.contentMode = .scaleAspectFit
        
        view.addSubview(imageUpDown)
        view.addSubview(dynamicLabelText)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(roomOptions))
        view.addGestureRecognizer(tapGesture)
        return view
    }
    
    func setEmptyView(isHidden: Bool) {
        emptyView.isHidden = isHidden
        collectionTemp.isHidden = !isHidden
    }
    
    func updateContentHeight() {
        colHeight.constant = collectionTemp.contentSize.height
    }
    
    func xibRegisterations() {
        collectionTemp.register(UINib(nibName: "DashboardTempCell", bundle: nil), forCellWithReuseIdentifier: "DashboardTempCell")
        servicesCollection.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forCellWithReuseIdentifier: "HeaderSupplementaryView")
        collectionTemp?.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "HeaderSupplementaryView")
        servicesCollection.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
    }
    
    //------------------------------------------
    //MARK: - Action Methods -
    @objc func btnAlertTapped(sender: UIButton) {
        if sender.tag == 0 {
        } else if sender.tag == 1 {
            let initiliazeVC: HomeSettings = Utilities.viewController(name: "HomeSettings", onStoryboard: "Settings") as! HomeSettings
            initiliazeVC.hidesBottomBarWhenPushed = true
            navigationController!.pushViewController(initiliazeVC, animated: true)
        } else {
            setEmptyView(isHidden: false)
        }
    }
    
    @objc func didSelectSection(_ gesture: UITapGestureRecognizer) {
        if let view = gesture.view {
            let tappedSection = view.tag
            print("here you can identify which section has been tapped section Number: \(tappedSection)")
            let resultVC = Utilities.viewController(name:"SingleRoomViewController", onStoryboard: "SingleRoom") as! SingleRoomViewController
            resultVC.temperatureData = temperatureData[tappedSection]
            navigationController!.pushViewController(resultVC, animated: true)
        }
    }
    
    @objc func roomOptions() {
        dropDown.show()
    }
}

//------------------------------------------
//MARK: - Collection Delegates -
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == servicesCollection {
            return 1
        } else {
            return temperatureData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == servicesCollection {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as? HeaderSupplementaryView else {
                return HeaderSupplementaryView()
            }
            return headerView
        } else {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as? HeaderSupplementaryView else {
                return HeaderSupplementaryView()
            }
            headerView.lblSectionName.text = temperatureData[indexPath.section].sectionName
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectSection(_:)))
            print("here you can identify which section has been tapped section Number: \(indexPath.section)")
            headerView.tag = indexPath.section
            headerView.addGestureRecognizer(tapGesture)
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == servicesCollection {
            return data.count
        } else {
            return temperatureData[section].sectionData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == servicesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            cell.lblServiceName.text = data[indexPath.row].text
            cell.imgService.image = UIImage(named: data[indexPath.row].imageName)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardTempCell", for: indexPath) as! DashboardTempCell

            let attributedString = temperatureData[indexPath.section].sectionData[indexPath.row].temperature.attributedString(false)
            cell.lblTemp.attributedText = temperatureData[indexPath.section].sectionData[indexPath.row].isSwitchOn ? attributedString : attributedString
            cell.lblRoomName.text = temperatureData[indexPath.section].sectionData[indexPath.row].roomName + " - \(temperatureData[indexPath.section].sectionData[indexPath.row].temperature)°"
            cell.lblDeviceName.text = temperatureData[indexPath.section].sectionData[indexPath.row].deviceName
            
            let isSwitchOn = temperatureData[indexPath.section].sectionData[indexPath.row].isSwitchOn
            let isConnected = temperatureData[indexPath.section].sectionData[indexPath.row].isConnected
            let isPaused = temperatureData[indexPath.section].sectionData[indexPath.row].isPaused

            if isSwitchOn {
                cell.imgBackground.image = UIImage(named: "in_gradientTheme")
                cell.temperatureSwitch.isHidden = false
                cell.lblTemp.textColor = appConfig.appColors.themeColor
                cell.lblRoomName.textColor = appConfig.appColors.themeColor
                cell.lblDeviceName.textColor = appConfig.appColors.themeColor

                if isConnected {
                    cell.imgOffline.isHidden = true
                    cell.imgPause.image = isPaused ? UIImage(named: "in_themePause") : UIImage(named: "in_exclamationMark")
                } else {
                    cell.imgOffline.isHidden = false
                    cell.imgOffline.image = UIImage(named: "in_wifiSlash")
                    cell.imgPause.image = isPaused ? UIImage(named: "in_themePause") : UIImage(named: "in_exclamationMark")
                }
            } else {
                cell.imgBackground.image = UIImage(named: "in_gradientGray")
                cell.temperatureSwitch.isHidden = false
                cell.lblTemp.textColor = appConfig.appColors.btnInActiveTextColor
                cell.lblRoomName.textColor = appConfig.appColors.btnInActiveTextColor
                cell.lblDeviceName.textColor = appConfig.appColors.btnInActiveTextColor
                cell.imgOffline.isHidden = true
                cell.imgOffline.image = UIImage(named: "in_wifiSlash")
                cell.imgPause.image = isPaused ? UIImage(named: "in_grayPause") : UIImage(named: "in_exclamationMark")
            }

            cell.temperatureSwitch.isOn = temperatureData[indexPath.section].sectionData[indexPath.row].isSwitchOn
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == servicesCollection {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 62.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == servicesCollection {
            let size = (data[indexPath.row].text as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 16) as Any])
            return CGSize(width: size.width + 52.0, height: 76)
        } else {
            let width = collectionView.bounds.width
            let numberOfItemsPerRow: CGFloat = 2
            let spacing: CGFloat = flowLayout.minimumInteritemSpacing
            let availableWidth = width - spacing * (numberOfItemsPerRow)
            let itemDimension = floor(availableWidth / numberOfItemsPerRow)
            return CGSize(width: itemDimension, height: 105)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1.0
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let initiliazeVC : DeviceDetailsViewController = Utilities.viewController(name: "DeviceDetailsViewController", onStoryboard: "DeviceDetails") as! DeviceDetailsViewController
        initiliazeVC.hidesBottomBarWhenPushed = true
        navigationController!.pushViewController(initiliazeVC, animated: true)
    }
}
extension Double {
    func attributedString(_ isFromDetail: Bool) -> NSAttributedString {
        
        let beforeDecimalFont = UIFont(name: isFromDetail ? "HelveticaNeue-Thin" : "HelveticaNeue-Bold" , size: isFromDetail ? 60 : 30)!
        let afterDecimalFont = UIFont(name: isFromDetail ? "HelveticaNeue-Thin" :  "HelveticaNeue-Bold", size: isFromDetail ? 45 : 16)!
        
        let numberString = "\(self)°"
        let attributedString = NSMutableAttributedString(string: numberString)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: beforeDecimalFont
        ]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: numberString.count))
        
        if let decimalRange = numberString.range(of: ".") {
            let decimalLocation = numberString.distance(from: numberString.startIndex, to: decimalRange.lowerBound)
            
            let beforeDecimalAttributes: [NSAttributedString.Key: Any] = [
                .font: beforeDecimalFont
            ]
            attributedString.addAttributes(beforeDecimalAttributes, range: NSRange(location: 0, length: decimalLocation))
            
            let afterDecimalAttributes: [NSAttributedString.Key: Any] = [
                .font: afterDecimalFont
            ]
            let afterDecimalLength = numberString.count - decimalLocation - 1
            attributedString.addAttributes(afterDecimalAttributes, range: NSRange(location: decimalLocation + 1, length: afterDecimalLength))
        }
        
        return attributedString
    }
}
