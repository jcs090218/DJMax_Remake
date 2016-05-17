public class ObjectPool{
  
  private int totalObject = 0;
  private GameObject gameObject = null;
  private Block[] objects = null;
  private boolean[] checkObjects = null;
  
  public ObjectPool(int num, GameObject gb){
    this.totalObject = num;
    this.gameObject = gb;
    this.objects = new Block[num];
    this.checkObjects = new boolean[num];
    
    createPool();
  }
  
  /**
   *  Create the actual pool
   */
  public void createPool(){
    for(int i = 0; i < totalObject; i++){
      objects[i] = new Block();    // assume we are using Block() for now
      checkObjects[i] = true;
    }
  }// end createPool()
  
  public void update(){
    for(int i = 0; i < totalObject; i++){  // this will draw everything in the pool
      if(!checkObjects[i]){      // if false we draw object
        objects[i].update();
      }
    }// end for(){ }
  }// end update()
  
  public void execute(int rows){
    int i;
    for(i = 0; i < totalObject; i++){
      if(checkObjects[i] == true){
        objects[i].setRow(rows);
        checkObjects[i] = false;
        break;
      }
    }
  }// end execute()
  
  public void backToPool(GameObject returnObject){
    int i;
    for(i = 0; i < totalObject; i++){
      if(objects[i] == returnObject){
        checkObjects[i] = true;      // turn boolean on than can be reuse
        break;
      }
    }
  }// end backToPool
  
  public int getTotalNum(){
    return this.totalObject;
  }// end getTotalNum()
  
  public Block getObject(int index){
    return this.objects[index];
  }// end getObejct
  
}// end class ObjectPool



