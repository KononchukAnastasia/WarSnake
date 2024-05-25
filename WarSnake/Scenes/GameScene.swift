//
//  GameScene.swift
//  WarSnake
//
//  Created by Анастасия Конончук on 13.05.2024.
//

import SpriteKit
import GameplayKit

final class GameScene: ParentScene {
    
    // MARK: - Public properties
    var backgroundMusic: SKAudioNode!
    
    // MARK: - Private properties
    private var player: PlayerSnake!
    private let hud = HUD()
    private let screenSize = UIWindow.bounds.size
    
    private let blueName = "BluePowerUp"
    private let yellowName = "YellowPowerUp"
    
    private var lives = 3 {
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    // MARK: - Initialization
    override func didMove(to view: SKView) {
        
        gameSettings.loadGameSettings()
        
        if gameSettings.isMusic && backgroundMusic == nil {
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a") {
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic)
            }
        }
        
        self.scene?.isPaused = false
        
        guard sceneManager.gameScene == nil else { return }
        
        sceneManager.gameScene = self
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnFlower()
        player.performСrawl()
        spawnPowerUp()
        spawnEnemies()
        createHUD()
    }
    
    // MARK: - Private methods
    private func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    private func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    private func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.enemy1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy2Atlas
           SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
               let randomNumber = Int(arc4random_uniform(2))
               let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
               let textureAtlas = arrayOfAtlases[randomNumber]
               
               let waitAction = SKAction.wait(forDuration: 1.0)
               let spawnEnemy = SKAction.run { [unowned self] in
                   let textureNames = textureAtlas.textureNames.sorted()
                   let texture = textureAtlas.textureNamed(textureNames[0])
                   let enemy = Enemy(enemyTexture: texture)
                   enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                   self.addChild(enemy)
                   enemy.flySpiral()
               }
               
               let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
               let repeatAction = SKAction.repeat(spawnAction, count: 3)
               
               self.run(repeatAction)
           }
       }
    
    private func spawnPowerUp() {
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : YellowPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width))
            
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
    }
    
    private func spawnFlower() {
        let spawnFlowerWait = SKAction.wait(forDuration: 1)
        let spawnFlowerAction = SKAction.run {
            let flower = Flower.populateFlower(at: nil)
            self.addChild(flower)
        }
        
        let spawnFlowerSequence = SKAction.sequence([spawnFlowerWait, spawnFlowerAction])
        let spawnFlowerForever = SKAction.repeatForever(spawnFlowerSequence)
        run(spawnFlowerForever)
    }
    
    private func configureStartScene() {
        let screenCenterPoint = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2
        )
        
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIWindow.bounds
            
        let flower1 = Flower.populateFlower(at: CGPoint(x: 100, y: 200))
        self.addChild(flower1)
        
        let flower2 = Flower.populateFlower(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(flower2)
        
        player = PlayerSnake.populate(at: CGPoint(x: screen.size.width / 2, y: 90))
        self.addChild(player)
    }
    
    private func playerFire() {
        let shot = YellowShot()
        shot.position = CGPoint(x: self.player.position.x, y: self.player.position.y + 40)
        shot.startMovement()
        self.addChild(shot)
    }
    
    // MARK: - Override methods
    override func didSimulatePhysics() {
        player.checkPozition()
        
        enumerateChildNodes(withName: "Sprite") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "ShotSprite") { (node, stop) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "YellowPowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "BluePowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "pause" {
            let transition = SKTransition.doorway(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene?.view?.presentScene(pauseScene, transition: transition)
        } else {
            playerFire()
        }
    }
}

// MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        
        let waitForExplosionAction = SKAction.wait(forDuration: 1)
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
        case [.enemy, .player]:
            if contact.bodyA.node?.name == "Sprite" {
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    
                    if gameSettings.isSound {
                        self.run(SKAction.playSoundFileNamed("biteSound", waitForCompletion: false))
                    }
                    
                    lives -= 1
                }
            } else {
                if contact.bodyB.node?.parent != nil {
                    contact.bodyB.node?.removeFromParent()
                    
                    if gameSettings.isSound {
                        self.run(SKAction.playSoundFileNamed("biteSound", waitForCompletion: false))
                    }
                    
                    lives -= 1
                }
            }
            addChild(explosion!)
            self.run(waitForExplosionAction) {
                explosion?.removeFromParent()
            }
            
            if lives == 0 {
                gameSettings.currentScore = hud.score
                gameSettings.saveScores()
                
                self.removeAllActions()
                
                if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("gameOverSound", waitForCompletion: false))
                }
                
                let wait = SKAction.wait(forDuration: 0.3)
                let changeScene = SKAction.run {
                    let gameOverScene = GameOverScene(size: self.size)
                    gameOverScene.scaleMode = .aspectFill
                    let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)
                    self.scene!.view?.presentScene(gameOverScene, transition: transition)
                }
                self.run(SKAction.sequence([wait, changeScene]))
                    
            }
        case [.powerUp, .player]:
            guard contact.bodyA.node?.parent != nil,
                  contact.bodyB.node?.parent != nil
            else { break }
            
            if let bodyA = contact.bodyA.node?.name,
               bodyA == blueName || bodyA == yellowName {
                updateLivesAndFlashPowerUp(name: bodyA)
                contact.bodyA.node?.removeFromParent()
            } else if let bodyB = contact.bodyB.node?.name,
                      bodyB == blueName || bodyB == yellowName {
                updateLivesAndFlashPowerUp(name: bodyB)
                contact.bodyB.node?.removeFromParent()
            }
        case [.enemy, .shot]:
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                
                if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                }
                
                hud.score += 5
                addChild(explosion!)
                self.run(waitForExplosionAction) {
                    explosion?.removeFromParent()
                }
            }
            
        default: preconditionFailure("Unable to detect collision category")
        }
    }
    
    private func updateLivesAndFlashPowerUp(name: String?) {
        guard let name = name else { return }
        
        if gameSettings.isSound {
            run(SKAction.playSoundFileNamed(
                "powerUpSound",
                waitForCompletion: false
            ))
        }
        
        switch name {
        case blueName:
            lives = 3
            player.bluePowerUp()
        case yellowName:
            if lives < 3 {
                lives += 1
            }
            
            player.yellowPowerUp()
        default:
            break
        }
    }
}
