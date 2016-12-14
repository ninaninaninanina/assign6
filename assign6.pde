
Bullet bulletArray [] ;
Enemy  enemyArray [] ;


/*** 以下是 FlameManager 的使用方式 */

FlameManager flameManager ; 
final int yourFrameRate = 30 ;


void setup (){
  
  
  size(400,400);
  
  frameRate(yourFrameRate) ;
  flameManager = new FlameManager( yourFrameRate / 5 ) ; // 每 200 秒播一張 

}

void draw (){
  
  background(0);
  
  // 畫出所有火焰
  flameManager.display();

}
void mouseClicked (){
  
  // 在爆炸發生點新增一個火焰動畫
  flameManager.add(mouseX , mouseY);

}