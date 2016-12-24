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
PImage bgTwo, bgOne;
PImage start2, start1;
PImage end2, end1;
PImage hp;
PImage treasureImg;
PImage sh;
PImage flame;

//hp
HPBar hpBar;
final float DIVIDE=10.0;
float hpLength;

//background
float bgTwoX, bgOneX;

//treasure
Treasure treasure;

//gamestatus
int gameStatus=0;

void setup () {
  size(640, 480);
  enemyImg = loadImage("img/enemy.png");
  enemyState = E_LINE ;
  arrangeLineEnemy() ;

  fighter      = new Fighter ();
  flameManager = new FlameManager( yourFrameRate / 5 ) ; // this means update 5 images in 1 second.
  hpBar= new HPBar(10, 10, "img/hp.png");
  treasure= new Treasure(100, 100, "img/treasure.png");

  //bg

  bgTwo=loadImage("img/bg1.png");
  bgOne=loadImage("img/bg2.png");
  bgTwoX=0;
  bgOneX=-640;
  
  //hp
  hpLength=20;
}

void draw () {



  // +_+ : display background
  // ...
  background(0) ;


  //background
  image(bgTwo, bgTwoX, 0);
  image(bgOne, bgOneX, 0);

  bgTwoX ++;
  bgOneX ++; // bg1 move with bg2

  if (bgTwoX==0)
  {
    bgOneX= (bgTwoX% 640) -640;
  } //whenever bg2 moves out of the screen, bg1 fills up the blank

  if (bgOneX==0)
  {    
    bgTwoX= (bgOneX% 640) -640;
  } // whenever bg1 moves out of the screen, bg1 fills up the blank



  hpBar.display(20);
  treasure.display();


  //meet with treasure



boolean T= isHit(fighter.x, fighter.y, 51.0, 51.0, treasure.x, treasure.y, 51.0, 51.0);
  if (T)
  {
    treasure.x=(int)random( 0, width-60);
    treasure.y=(int)random( 50, height-42);
    hpLength+=196/DIVIDE;
    if (hpLength>196.0)
    {
      hpLength=196.0;
    }
  }
  
  hpBar.display(hpLength);





  //===============
  //  ENEMY COLLISION TEST 
  //===============

  for (int i = 0; i < enemyAmount; i++) {
    enemyArray[i].move() ;

    // +_+ : collision detection : enemy & bullets  
    // ....

    // +_+ : collision detection : enemy & fighter
    if (enemyArray[i].isHit(fighter.x, fighter.y, fighter.img.width, fighter.img.height )) {

      //cut hp
     // float hpLength;
       // hpBar.display(hp);
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

void keyPressed() {
  fighter.keyPressed(keyCode) ;

  // +_+ : don't fordet to shoot bullet.
}
void keyReleased() {
  fighter.keyReleased(keyCode) ;
}








//===============
//  FUNCTIONS :
//===============
//  use them directly.

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh)
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
      enemyArray[i] = new Enemy( -50 - i * (enemyImg.width + 10), y ) ;
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
