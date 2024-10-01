import SpriteKit
import SwiftUI

class SpinGameScene: SKScene {
    
    
    let segmentPrizes = [
        -1, 0, 10, 20, 30, 40, -2, 60, 70, 80, 90, 20
    ]
    let wheelSegments = 12
    
    var userBalance = UserDefaults.standard.integer(forKey: Keys.userCoins) {
        didSet {
            UserDefaults.standard.set(userBalance, forKey: Keys.userCoins)
            userBalanceLabel.text = "\(userBalance)"
        }
    }
    private var userBalanceLabel: SKLabelNode!
    
    private var rouletteState = "" {
        didSet {
            if rouletteState == "" || rouletteState.contains("WIN") {
                spinBtnLabel.text = "SPIN"
            } else {
                spinBtnLabel.text = ""
            }
            rouletteStateLabel.text = "\(rouletteState)"
        }
    }
    private var rouletteStateLabel: SKLabelNode!
    
    private var rouletteNode: SKSpriteNode!
    private var spinBtnLabel: SKLabelNode!
    
    private var determineRouletteLayout: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 2400, height: 1000)
        createBackground()
        createUI()
    }
    
    private func createUI() {
        let balanceBackground = SKSpriteNode(imageNamed: "balance_background")
        balanceBackground.position = CGPoint(x: size.width - 300, y: size.height - 150)
        balanceBackground.size = CGSize(width: 400, height: 180)
        addChild(balanceBackground)
        
        userBalanceLabel = .init(text: "\(userBalance)")
        userBalanceLabel.position = CGPoint(x: size.width - 250, y: size.height - 170)
        userBalanceLabel.fontName = "RammettoOne-Regular"
        userBalanceLabel.fontSize = 52
        userBalanceLabel.fontColor = UIColor.init(red: 230/255, green: 184/255, blue: 69/255, alpha: 1)
        addChild(userBalanceLabel)
        
        let home = SKSpriteNode(imageNamed: "home")
        home.name = "home"
        home.position = CGPoint(x: 200, y: 250)
        home.size = CGSize(width: home.size.width, height: 300)
        addChild(home)
        
        rouletteStateLabel = .init(text: "\(rouletteState)")
        rouletteStateLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + 300)
        rouletteStateLabel.fontName = "RammettoOne-Regular"
        rouletteStateLabel.fontSize = 140
        rouletteStateLabel.fontColor = UIColor.init(red: 230/255, green: 184/255, blue: 69/255, alpha: 1)
        addChild(rouletteStateLabel)
        
        let rouletteBack = SKSpriteNode(imageNamed: "fortune_back")
        rouletteBack.position = CGPoint(x: size.width / 2, y: 0)
        rouletteBack.size = CGSize(width: 1140, height: 1100)
        addChild(rouletteBack)
        
        rouletteNode = SKSpriteNode(imageNamed: "fortune_small")
        rouletteNode.position = CGPoint(x: size.width / 2, y: 0)
        rouletteNode.size = CGSize(width: 1140, height: 1100)
        addChild(rouletteNode)
        
        let spinRouletteBtn = SKSpriteNode(imageNamed: "spin_fortune")
        spinRouletteBtn.position = CGPoint(x: size.width / 2, y: 0)
        spinRouletteBtn.name = "spin"
        spinRouletteBtn.zPosition = 7
        addChild(spinRouletteBtn)
        
        spinBtnLabel = SKLabelNode(text: "SPIN")
        spinBtnLabel.position = CGPoint(x: size.width / 2, y: 20)
        spinBtnLabel.fontName = "RammettoOne-Regular"
        spinBtnLabel.fontSize = 72
        spinBtnLabel.name = "spin"
        spinBtnLabel.zPosition = 7
        spinBtnLabel.fontColor = UIColor.init(red: 230/255, green: 184/255, blue: 69/255, alpha: 1)
        addChild(spinBtnLabel)
                        
        determineRouletteLayout = SKSpriteNode(color: .clear, size: rouletteNode.size)
        determineRouletteLayout.position = rouletteNode.position
        addChild(determineRouletteLayout)
        
        let itemAngle = 2 * .pi / CGFloat(wheelSegments)
        
        for i in 0..<wheelSegments {
            let prize = segmentPrizes[i]
                
            // Создаем прозрачные сегменты для определения призов
            let determineNodeItem = SKSpriteNode(color: .clear, size: CGSize(width: 1000, height: 110)) // Уменьшенный размер
            determineNodeItem.anchorPoint = CGPoint(x: 0.5, y: 1)
            determineNodeItem.position = CGPoint(x: 0, y: 0)
            determineNodeItem.zRotation = -(itemAngle * CGFloat(i) - .pi / 2)
            determineNodeItem.name = "\(prize)"
            
            // Добавляем сегмент к родительскому узлу
            determineRouletteLayout.addChild(determineNodeItem)
        }
    }
    
    func createBackground() {
        let backgroundNode = SKSpriteNode(imageNamed: "slot_chooser_bg")
        backgroundNode.size = size
        backgroundNode.zPosition = -1
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(backgroundNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first {
            let touchedObject = atPoint(t.location(in: self))
            
            if touchedObject.name == "home" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                NotificationCenter.default.post(name: Notification.Name("go_home"), object: nil)
            }
            
            if touchedObject.name == "spin" {
                touchedObject.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.1), SKAction.fadeAlpha(to: 1, duration: 0.1)]))
                spinFortune()
            }
        }
    }
    
    private func spinFortune() {
        rouletteState = "SPINNING..."
        let randomSpins = CGFloat(Int.random(in: 3...6))
        
        let randomEndAngle = CGFloat.random(in: 0...360)
    
        let totalRotation = randomSpins * 360 + randomEndAngle
        
        let spinAction = SKAction.rotate(byAngle: totalRotation * (.pi / 180), duration: 3)
        rouletteNode.run(spinAction) {
            self.checkPrize()
        }
        determineRouletteLayout.run(spinAction)
    }
    
    private func checkPrize() {
        // Проверяем, что точка выигрыша попала на сегмент
        let winningNode = atPoint(CGPoint(x: size.width / 2, y: 350))
        
        if let prizeName = winningNode.name, let prize = Int(prizeName) {
            if prize == -1 {
                userBalance += 1000
            } else if prize == -2 {
                userBalance += 5000
            } else {
                userBalance += prize
            }
            
            rouletteState = "WIN: \(prize)"
        } else {
        }
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: SpinGameScene())
            .ignoresSafeArea()
    }
}
