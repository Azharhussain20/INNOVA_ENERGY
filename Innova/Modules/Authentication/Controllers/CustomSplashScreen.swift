import UIKit

class CustomSplashScreen: UIViewController {
    
    //------------------------------------------
    //MARK: - Outlets -
    @IBOutlet weak var ConfettiView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    //------------------------------------------
    //MARK: - Class Variables -
    
    //MARK: - Memory Management -
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit
    {
        
    }
    
    //------------------------------------------
    //MARK: - View Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut, animations: {
            // Scale the logo up
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        }) { _ in
            let confettiCell1 = self.createEmitterCell(imageName: "confetti1")
            let confettiCell2 = self.createEmitterCell(imageName: "confetti2")
            let confettiCell3 = self.createEmitterCell(imageName: "confetti3")
            let confettiCell4 = self.createEmitterCell(imageName: "confetti4")
            let confettiCell5 = self.createEmitterCell(imageName: "confetti5")
            let emitterLayer = CAEmitterLayer()
            emitterLayer.emitterPosition = CGPoint(x: self.view.bounds.width / 2, y: -50)
            emitterLayer.emitterShape = .line
            emitterLayer.emitterSize = CGSize(width: self.view.bounds.width, height: 1)
            emitterLayer.emitterCells = [confettiCell1, confettiCell2, confettiCell3, confettiCell4, confettiCell5]
            self.ConfettiView.layer.addSublayer(emitterLayer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                UIView.animate(withDuration: 0.5, animations: {
                    emitterLayer.emitterPosition = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height + 50)
                    self.logoImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }) { _ in
                    emitterLayer.removeFromSuperlayer()
                    self.navigateToMainScreen()
                }
            }
        }
    }
    
    func createEmitterCell(imageName: String) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 14.0
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scale = 0.5
        cell.scaleRange = 0.2
        cell.contents = UIImage(named: imageName)?.cgImage
        return cell
    }
    
    //------------------------------------------
    //MARK: - API Methods -
    
    //------------------------------------------
    //MARK: - Custom Methods -
    func navigateToMainScreen() {
        AppInstance.goToIntroDuctionPage(transition: true)
    }
    //------------------------------------------
    //MARK: - Action Methods -
}
