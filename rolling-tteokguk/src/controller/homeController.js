import Ricecake from "../model/ricecake.js";

export class Controller {
  constructor() {
    this.age = 0;
    this.ricecakes = [];
    this.setup();
  }

  setup(){
    if(localStorage.getItem('age') === null){
      localStorage['age'] = 0;
    }
    
    if(localStorage.getItem('ricecakes') !== null){
      this.age = Number(localStorage['age']);
      this.ricecakes = JSON.parse(localStorage['ricecakes']);
      console.log(this.ricecakes);
    }
  }

  addRicecake(name, message){
    this.age += 1;
    localStorage['age'] = this.age;
    this.ricecakes.push(new Ricecake(this.age,name,message,0,0));
    localStorage.setItem('ricecakes', JSON.stringify(this.ricecakes));
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
    this.ricecakes[id].left = x;
    this.ricecakes[id].top = y;
  }

  moved(id, x, y){
    this.ricecakes[id].left = x;
    this.ricecakes[id].top = y;
    localStorage.setItem('ricecakes', JSON.stringify(this.ricecakes));
  }
}
