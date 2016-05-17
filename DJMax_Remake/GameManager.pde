public class GameManager{
  
  // Scene
  private BackgroundEffect bgeft = null;
  
  // Button and Effect
  private Button[] btn = new Button[buttons];
  private ButtonEffect[] eft = new ButtonEffect[buttons];
  
  // scene object components
  private float sideStrokeWidth = 10;
  private float strokeAlpha = 127;
  private float backgroundAlpha = 127;
  private static final float SIDE_STROKE_HEIGHT
                                = SCREEN_HEIGHT;
  // Pool
  public ObjectPool blockPool = null;
  
  private boolean bAddCombo = false;
  private int targetCombo = 0;
  
  
  public GameManager(){
    if(totalButton.length == 2){
      startPosition = 100;
    }else if(totalButton.length == 4){
      startPosition = 30;
    }else if(totalButton.length == 7){
      startPosition = 20;
    }else startPosition = 10;
    
    blockPool = new ObjectPool(20, new Block());
    bgeft = new BackgroundEffect(startPosition);
  }
  
  public void initScene(){
    setBackground();
    offsetRowPosition();
  }
  PImage img = null;
  private void setBackground(){
    img = new PImage();
    img = loadImage("background_01.jpg");
  }
  
  private void displayObject(float _sideStroekWidth){
    // background (only rows)
    fill(0,0,0,backgroundAlpha);
    rect(startPosition,
          -1, 
          (sideStrokeWidth * 2) + (blockWidth * buttons) - sideStrokeWidth,
          SIDE_STROKE_HEIGHT);
    
    // left
    //noStroke();
    fill(255,255,127,strokeAlpha);
    rect(startPosition - _sideStroekWidth, -1,
            _sideStroekWidth,SIDE_STROKE_HEIGHT);
    // right
    //noStroke();
    fill(255,255,127,strokeAlpha);
    rect(startPosition+ (buttons * blockWidth), -1,
            _sideStroekWidth,SIDE_STROKE_HEIGHT);
  }// end displayObject()
  
  private void offsetRowPosition(){
    for(int i = 0; i < totalButton.length; i++){
      btn[i] = new Button(startPosition + (i * blockWidth));
      eft[i] = new ButtonEffect(startPosition + (i * blockWidth));
    }
  }// end offsetRowPosition()
  
  public void update(){
    smooth();
    image(img,0,0);
    bgeft.update();
    blockPool.update();
    onAddCombo();
    
    displayObject(sideStrokeWidth);
    if(buttons == 2){
      if(fKey) eft[0].update();
      if(jKey) eft[1].update();
    }else if(buttons == 4){
      if(dKey) eft[0].update();
      if(fKey) eft[1].update();
      if(jKey) eft[2].update();
      if(kKey) eft[3].update();
    }else if(buttons == 7){
      if(sKey) eft[0].update();
      if(dKey) eft[1].update();
      if(fKey) eft[2].update();
      if(spaceKey) eft[3].update();
      if(jKey) eft[4].update();
      if(kKey) eft[5].update();
      if(lKey) eft[6].update();
    }
    count();
    
    for(int i = 0; i < totalButton.length; i++){
      btn[i].update();
    }
  }// end update();
  
  private void count(){
    if(hVal > 255){
      hVal = 0;
    }else hVal += 0.8;
  }// end count()
  
  public void checkHitBlock(int rows){
    // ((COLUMN_BUTTON_POSITION + blockHeight) - TIGGER_DISTANCE)
    
    for(int i = 0; i < gm.blockPool.getTotalNum(); i++){
      if(rows == blockPool.getObject(i).getRows()){    // check row first
        if(((COLUMN_BUTTON_POSITION + blockHeight) - TIGGER_DISTANCE)
              <= blockPool.getObject(i).getPosY() &&
              (COLUMN_BUTTON_POSITION + blockHeight) 
              >= blockPool.getObject(i).getPosY()){        // check object in distance or not
          this.blockPool.backToPool(this.blockPool.getObject(i));
          addCombo(1);
          break;
        }
      }
    }// end for(){ }
  }// end checkHitBlock()
  
  public void addCombo(int addNum){
    if(!bAddCombo && addNum != 0){
      targetCombo += addNum;
      bAddCombo = true;
    }
  }// end addCombo()
  
  private void onAddCombo(){
    if(bAddCombo){
      if(targetCombo != combo){
        combo = targetCombo;
      }else bAddCombo = false;
    }
  }// end onAddCombo()
  
  public void setTargetCombo(int newNum){
    this.targetCombo = newNum;
  }// end setTargetCombo()
  
}// end Class
