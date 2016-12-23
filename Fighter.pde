class Fighter {
  int x ;
  int y ;
  PImage img ; 
  int speed ;

  private boolean up = false ;
  private boolean down = false ;
  private boolean left = false ;
  private boolean right = false ;

  Fighter () {
    img = loadImage("img/fighter.png");
    speed = 3 ;
    x = width - 50 ;
    y = height /2 ;
  }

  void display () {   
    // ... 
  }

  void move () {
    if (up    && y - speed > 0      ) y -= speed ;
    if (down  && y + speed < height ) y += speed ;
    if (right && x + speed < width  ) x += speed ;
    if (left  && x - speed > 0 ) x -= speed ;
  }


  void keyPressed (int keyCode) {
    switch (keyCode) {
    case UP    : 
      up = true ;   
      break ;
    case DOWN  : 
      down = true ; 
      break ;
    case LEFT  : 
      left = true ; 
      break ;
    case RIGHT : 
      right = true ;
      break ;
    }
  }
  void keyReleased (int keyCode) {
    switch (keyCode) {
    case UP    : 
      up =    false ; 
      break ;
    case DOWN  : 
      down =  false ; 
      break ;
    case LEFT  : 
      left =  false ; 
      break ;
    case RIGHT : 
      right = false ; 
      break ;
    }
  }
}