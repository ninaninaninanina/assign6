class HPBar {
  int x , y ;
  PImage img ;
  
  HPBar (int x, int y ,String imgPath){
    this.x = x ;
    this.y = y ;
    img = loadImage(imgPath); 
  }
  
  void display(int hp){
    // display the hp 
  }
  
}