// 戰隊的最大值
final int enemyAmount = 8 ;

// 用來管理所有的 enemy 和 boss
Enemy[] enemyArray = new Enemy[enemyAmount] ;


// enemy states
final int E_LINE = 0    ;
final int E_SLASH = 1   ; 
final int E_DIAMOND = 2 ;
final int E_BOSS = 3    ;

// enemy state
int enemyState ;


// FlameManager 
FlameManager flameManager ; 
final int yourFrameRate = 30 ;
Fighter fighter ; 


// shared images ; 
PImage enemyImg ;

void setup () {
  size(640, 480);
  enemyImg = loadImage("img/enemy.png");
  enemyState = E_LINE ;
  arrangeLineEnemy() ;
  
  fighter      = new Fighter ();
  flameManager = new FlameManager( yourFrameRate / 5 ) ; // this means update 5 images in 1 second.
}

void draw () {



  // +_+ : display background
  // ...
  background(0) ;



  //===============
  //  ENEMY COLLISION TEST 
  //===============

  for (int i = 0; i < enemyAmount; i++) {
    enemyArray[i].move() ;

    // +_+ : collision detection : enemy & bullets  
    // ....
    
    // +_+ : collision detection : enemy & fighter
    if (enemyArray[i].isHit(fighter.x, fighter.y, fighter.img.width, fighter.img.height )) {

      //  +_+ : explosion
      flameManager.add(enemyArray[i].x, enemyArray[i].y );

      //  +_+ : then move out the enemy 
      enemyArray[i].x = width ;
    }

    // +_+ : show the enemy 
    enemyArray[i].display();
  }

  // +_+ : this will draw all flames.
  flameManager.display();
  
  
  fighter.move();
  
  // +_+ : add some code in the fighter.display method ;
  fighter.display();  



  //===============
  //  REARRANGE ENEMY !! 
  //===============

  // when all enemy is out of screen :  
  if (enemyFinished()) {

    // switch to new enemyState 
    enemyState = (enemyState + 1) % 4 ;

    // arrange enemies to new shape. 
    switch (enemyState) {
    case E_LINE :   
      arrangeLineEnemy() ;   
      break ;
    case E_SLASH :  
      arrangeSlashEnemy() ;  
      break ;
    case E_DIAMOND : 
      arrangeDiamondEnemy() ; 
      break ;
    case E_BOSS :
      arrangeBossEnemy() ;   
      break ;
    }
  }
}

void keyPressed(){
  fighter.keyPressed(keyCode) ;
  
  // +_+ : don't fordet to shoot bullet. 
}
void keyReleased(){
  fighter.keyReleased(keyCode) ;
}








//===============
//  FUNCTIONS :
//===============
//  use them directly.

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
  // Collision x-axis?
  boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
  // Collision y-axis?
  boolean collisionY = (ay + ah >= by) && (by + bh >= ay);

  return collisionX && collisionY;
}


boolean enemyFinished() { 

  // if all enemy is out of screen    -> return true
  // if any enemy is inside of screen -> return false 

  for (int i = 0; i < 8; i++) {
    if (enemyArray[i].x < width) {
      return false ;
    }
  }
  return true ;
}


void arrangeLineEnemy () {
  float  y = random (0, 480 - 5 * enemyImg.height);
  for (int i = 0; i < 8; i++) {
    if (i < 5 ) {
      enemyArray[i] = new Enemy( -50 - i * (enemyImg.width + 10) , y ) ;
    } else {
      enemyArray[i] = new Enemy( width, y ) ;
    }
  }
}
void arrangeSlashEnemy () {
  float y = random (0, 480 - 5 * enemyImg.width );
  for (int i = 0; i < 8; i++) {
    if (i < 5 ) {
      enemyArray[i] = new Enemy( -50 - i * 51, y + i * enemyImg.height ) ;
    } else {
      enemyArray[i] = new Enemy( width, y ) ;
    }
  }
}
void arrangeDiamondEnemy () {
  float cx = -250 ;
  float cy = random(0 + 2 * enemyImg.height, 480 - 3 * enemyImg.height ) ;  
  int numPerSide = 3 ;

  int index = 0;
  for (int i = 0; i < numPerSide - 1; i++) {
    int rx = numPerSide - 1 - i ;
    int ry = i ;
    
    enemyArray[index++] = new Enemy( cx + rx * enemyImg.width, cy + ry * enemyImg.height );
    enemyArray[index++] = new Enemy( cx - rx * enemyImg.width, cy - ry * enemyImg.height );
    enemyArray[index++] = new Enemy( cx + ry * enemyImg.width, cy - rx * enemyImg.height );
    enemyArray[index++] = new Enemy( cx - ry * enemyImg.width, cy + rx * enemyImg.height );
  }
}

void arrangeBossEnemy () {
  float y = random( 0, height - 5 * (enemyImg.height + 10) ) ; 
  for (int i = 0; i < 8; i++) {
    if (i < 5 ) {
      enemyArray[i] = new Boss( - width, y + i * (enemyImg.height + 10 ) ) ;
    } else {
      enemyArray[i] = new Boss ( width, y ) ;
    }
  }
}