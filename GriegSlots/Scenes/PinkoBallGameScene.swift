import SpriteKit
import SwiftUI

class PinkoBallGameScene: SKScene, SKPhysicsContactDelegate {
    
    var userBalance = UserDefaults.standard.integer(forKey: Keys.userCoins) {
        didSet {
            UserDefaults.standard.set(userBalance, forKey: Keys.userCoins)
            userBalanceLabel.text = "\(userBalance)"
        }
    }
    private var userBalanceLabel: SKLabelNode!
    
    private var totalWin = 0 {
        didSet {
            totalWinLabel.text = "\(totalWin)"
        }
    }
    private var totalWinLabel: SKLabelNode!
    
    private var totalBet = 100 {
        didSet {
            totalBetLabel.text = "\(totalBet)"
        }
    }
    private var totalBetLabel: SKLabelNode!
    
    private var autoSpin: SKSpriteNode!
    private var autoSpinEnabled = false {
        didSet {
            if autoSpinEnabled {
                autoSpin.run(SKAction.fadeAlpha(to: 0.8, duration: 0.2))
            } else {
                autoSpin.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
            }
        }
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 2400, height: 2048)
        physicsWorld.contactDelegate = self
        
        let backgroundNode = SKSpriteNode(imageNamed: "hera_background_image")
        backgroundNode.size = size
        backgroundNode.zPosition = -1
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(backgroundNode)
        
        let balanceBackground = SKSpriteNode(imageNamed: "balance_background")
        balanceBackground.position = CGPoint(x: size.width - 300, y: size.height - 250)
        balanceBackground.size = CGSize(width: 400, height: 300)
        addChild(balanceBackground)
        
        userBalanceLabel = .init(text: "\(userBalance)")
        userBalanceLabel.position = CGPoint(x: size.width - 300, y: size.height - 280)
        userBalanceLabel.fontName = "RammettoOne-Regular"
        userBalanceLabel.fontSize = 72
        userBalanceLabel.fontColor = UIColor.init(red: 230/255, green: 184/255, blue: 69/255, alpha: 1)
        addChild(userBalanceLabel)
        
        let home = SKSpriteNode(imageNamed: "home")
        home.name = "home"
        home.position = CGPoint(x: 200, y: 400)
        home.size = CGSize(width: home.size.width, height: 470)
        addChild(home)
        
        let spin = SKSpriteNode(imageNamed: "spin_btn")
        spin.name = "spin"
        spin.position = CGPoint(x: size.width / 2, y: 370)
        spin.size = CGSize(width: 250, height: 400)
        addChild(spin)
        
        let maxBet = SKSpriteNode(imageNamed: "max_bet")
        maxBet.name = "max_bet"
        maxBet.position = CGPoint(x: size.width / 2 - 280, y: 370)
        maxBet.size = CGSize(width: 200, height: 320)
        addChild(maxBet)
        
        autoSpin = SKSpriteNode(imageNamed: "auto_spin")
        autoSpin.name = "auto_spin"
        autoSpin.position = CGPoint(x: size.width / 2 + 280, y: 370)
        autoSpin.size = CGSize(width: 200, height: 320)
        addChild(autoSpin)
        
        let info = SKSpriteNode(imageNamed: "info")
        info.name = "info"
        info.position = CGPoint(x: size.width - 200, y: 400)
        info.size = CGSize(width: home.size.width, height: 470)
        addChild(info)
        
        let totalBetBackground = SKSpriteNode(imageNamed: "total_bet")
        totalBetBackground.position = CGPoint(x: 570, y: 370)
        totalBetBackground.size = CGSize(width: 430, height: 300)
        addChild(totalBetBackground)
        
        totalBetLabel = .init(text: "\(totalBet)")
        totalBetLabel.position = CGPoint(x: 570, y: 310)
        totalBetLabel.fontName = "RammettoOne-Regular"
        totalBetLabel.fontSize = 52
        totalBetLabel.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        addChild(totalBetLabel)
        
        let betPlus = SKLabelNode(text: "+")
        betPlus.position = CGPoint(x: 730, y: 305)
        betPlus.fontName = "RammettoOne-Regular"
        betPlus.fontSize = 72
        betPlus.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        betPlus.name = "bet_plus"
        addChild(betPlus)
        
        let betMinus = SKLabelNode(text: "-")
        betMinus.position = CGPoint(x: 410, y: 305)
        betMinus.fontName = "RammettoOne-Regular"
        betMinus.fontSize = 72
        betMinus.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        betMinus.name = "bet_minus"
        addChild(betMinus)
        
        let totalWinBackground = SKSpriteNode(imageNamed: "total_win")
        totalWinBackground.position = CGPoint(x: size.width - 570, y: 370)
        totalWinBackground.size = CGSize(width: 430, height: 300)
        addChild(totalWinBackground)
        
        totalWinLabel = .init(text: "\(totalWin)")
        totalWinLabel.position = CGPoint(x: size.width - 570, y: 310)
        totalWinLabel.fontName = "RammettoOne-Regular"
        totalWinLabel.fontSize = 52
        totalWinLabel.fontColor = UIColor.init(red: 237/255, green: 77/255, blue: 248/255, alpha: 1)
        addChild(totalWinLabel)
        
        let slotBackground = SKSpriteNode(imageNamed: "slot_background")
        slotBackground.position = CGPoint(x: size.width / 2, y: size.height / 2 + 100)
        slotBackground.size = CGSize(width: 1200, height: 1100)
        addChild(slotBackground)
        
        let starsCounter = SKSpriteNode(imageNamed: "stars_counter_bg")
        starsCounter.position = CGPoint(x: 300, y: size.height - 250)
        starsCounter.size = CGSize(width: starsCounter.size.width, height: 300)
        addChild(starsCounter)
    }
    
}

#Preview {
    VStack {
        VStack {
            SpriteView(scene: PinkoBallGameScene())
                .ignoresSafeArea()
        }
    }
}
