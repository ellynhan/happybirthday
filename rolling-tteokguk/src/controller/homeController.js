import Tteok from "../model/tteok.js";

export class Controller {
  constructor() {
    this.age = 0;
    this.tteoks = [];
    this.setup();
  }

  setup(){
    if(localStorage.getItem('age') === null){
      localStorage['age'] = 0;
    }
    
    if(localStorage.getItem('tteoks') !== null){
      this.age = Number(localStorage['age']);
      this.tteoks = JSON.parse(localStorage['tteoks']);
      console.log(this.tteoks);
    }
  }

  addTteok(name, message){
    this.age += 1;
    localStorage['age'] = this.age;
    this.tteoks.push(new Tteok(this.age,name,message,0,0));
    localStorage.setItem('tteoks', JSON.stringify(this.tteoks));
  }

  showMessageWindow(id){
    let arr = document.querySelectorAll('.message-window');
    let index = 0;
    arr.forEach((elem)=>{
      elem.style.display = 'none';
      if(id === index){
        elem.style.display = 'block';
      }
      index += 1;
    })
  }

  startMove(id, x, y){
    this.tteoks[id].left = x;
    this.tteoks[id].top = y;
  }

  moved(id, x, y){
    this.tteoks[id].left = x;
    this.tteoks[id].top = y;
    localStorage.setItem('tteoks', JSON.stringify(this.tteoks));
  }
}
