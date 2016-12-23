class Enemy {

  float x, y ;
  PImage img ; 
  float speed ; 
 
  Enemy (float x, float y) {
    this.x = x ; 
    this.y = y ;
    this.speed = 5;
    img = enemyImg ; 
    
  }

  void display () {
    image (img, x, y );
  }
  void move () {
    
    x+= speed ;
  }

  boolean isHit (int bx, int by, int bw, int bh ) {
    
    boolean collisionX = (this.x + this.img.width >= bx) && (bx + bw >= this.x);
    boolean collisionY = (this.y + this.img.height >= by) && (by + bh >= this.y);

    return collisionX && collisionY;
  }
}